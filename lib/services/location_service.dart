import 'dart:developer' as dev;
import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double _verificationRadiusMeters = 1000.0; // 1km threshold

  /// Check and request location permissions
  static Future<bool> requestLocationPermission() async {
    try {
      dev.log('LocationService: Checking location permission');
      
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        dev.log('LocationService: Location services are disabled');
        return false;
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          dev.log('LocationService: Location permissions are denied');
          return false;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        dev.log('LocationService: Location permissions are permanently denied');
        return false;
      }

      dev.log('LocationService: Location permission granted');
      return true;
    } catch (e) {
      dev.log('LocationService: Error requesting location permission: $e');
      return false;
    }
  }

  /// Get current location with timeout
  static Future<Position?> getCurrentLocation() async {
    try {
      dev.log('LocationService: Fetching current location');
      
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
      
      dev.log('LocationService: Current location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      dev.log('LocationService: Error getting current location: $e');
      return null;
    }
  }

  /// Calculate distance between two points using Haversine formula
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  /// Verify if current location is within verification radius of clinic
  static LocationVerificationResult verifyLocation(
    double currentLat,
    double currentLon,
    double? clinicLat,
    double? clinicLon,
  ) {
    if (clinicLat == null || clinicLon == null) {
      dev.log('LocationService: Clinic coordinates not available');
      return LocationVerificationResult(
        isVerified: false,
        distanceMeters: null,
        message: 'Clinic location not available',
      );
    }

    final distance = calculateDistance(
      currentLat,
      currentLon,
      clinicLat,
      clinicLon,
    );

    final isVerified = distance <= _verificationRadiusMeters;
    
    dev.log('LocationService: Distance to clinic: ${distance.toStringAsFixed(0)}m, Verified: $isVerified');
    
    return LocationVerificationResult(
      isVerified: isVerified,
      distanceMeters: distance,
      message: isVerified
          ? 'Location verified (${distance.toStringAsFixed(0)}m from clinic)'
          : 'You are ${_formatDistance(distance)} away from the clinic',
    );
  }

  /// Format distance for display
  static String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)}m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)}km';
    }
  }

  /// Complete location verification workflow
  static Future<LocationVerificationResult> performLocationVerification(
    double? clinicLat,
    double? clinicLon,
  ) async {
    try {
      dev.log('LocationService: Starting location verification workflow');
      
      // Step 1: Check permissions
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return LocationVerificationResult(
          isVerified: false,
          distanceMeters: null,
          message: 'Location permission denied',
        );
      }

      // Step 2: Get current location
      final position = await getCurrentLocation();
      if (position == null) {
        return LocationVerificationResult(
          isVerified: false,
          distanceMeters: null,
          message: 'Unable to get current location',
        );
      }

      // Step 3: Verify location
      return verifyLocation(
        position.latitude,
        position.longitude,
        clinicLat,
        clinicLon,
      );
    } catch (e) {
      dev.log('LocationService: Error in location verification: $e');
      return LocationVerificationResult(
        isVerified: false,
        distanceMeters: null,
        message: 'Location verification failed',
      );
    }
  }
}

class LocationVerificationResult {
  final bool isVerified;
  final double? distanceMeters;
  final String message;

  const LocationVerificationResult({
    required this.isVerified,
    required this.distanceMeters,
    required this.message,
  });

  @override
  String toString() {
    return 'LocationVerificationResult(isVerified: $isVerified, distanceMeters: $distanceMeters, message: $message)';
  }
}