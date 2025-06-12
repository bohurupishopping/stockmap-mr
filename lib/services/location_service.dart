// ignore_for_file: deprecated_member_use

import 'dart:developer' as dev;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/doctor_clinic_models.dart';

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

  /// Get address details from coordinates using reverse geocoding
  static Future<AddressDetails?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      dev.log('LocationService: Getting address for coordinates: $latitude, $longitude');
      
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        
        final addressDetails = AddressDetails(
          street: placemark.street ?? '',
          subLocality: placemark.subLocality ?? '',
          locality: placemark.locality ?? '',
          administrativeArea: placemark.administrativeArea ?? '',
          postalCode: placemark.postalCode ?? '',
          country: placemark.country ?? '',
          formattedAddress: _formatAddress(placemark),
        );
        
        dev.log('LocationService: Address found: ${addressDetails.formattedAddress}');
        return addressDetails;
      } else {
        dev.log('LocationService: No address found for coordinates');
        return null;
      }
    } catch (e) {
      dev.log('LocationService: Error getting address from coordinates: $e');
      return null;
    }
  }

  /// Format placemark into a readable address string
  static String _formatAddress(Placemark placemark) {
    List<String> addressParts = [];
    
    if (placemark.street?.isNotEmpty == true) {
      addressParts.add(placemark.street!);
    }
    if (placemark.subLocality?.isNotEmpty == true) {
      addressParts.add(placemark.subLocality!);
    }
    if (placemark.locality?.isNotEmpty == true) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea?.isNotEmpty == true) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.postalCode?.isNotEmpty == true) {
      addressParts.add(placemark.postalCode!);
    }
    if (placemark.country?.isNotEmpty == true) {
      addressParts.add(placemark.country!);
    }
    
    return addressParts.join(', ');
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

  /// Verify location against multiple clinics and return the best result
  static Future<LocationVerificationResult> performMultiClinicLocationVerification(
    List<DoctorClinic> clinics,
  ) async {
    try {
      dev.log('LocationService: Starting multi-clinic location verification for ${clinics.length} clinics');
      
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

      // Step 3: Check against all clinics
      LocationVerificationResult? bestResult;
      double? closestDistance;
      String? closestClinicName;
      
      for (final clinic in clinics) {
        if (clinic.latitude != null && clinic.longitude != null) {
          final result = verifyLocation(
            position.latitude,
            position.longitude,
            clinic.latitude,
            clinic.longitude,
          );
          
          // If this clinic is verified, return immediately
          if (result.isVerified) {
            dev.log('LocationService: Verified at clinic: ${clinic.clinicName}');
            return LocationVerificationResult(
              isVerified: true,
              distanceMeters: result.distanceMeters,
              message: 'Location verified at ${clinic.clinicName} (${result.distanceMeters?.toStringAsFixed(0)}m away)',
            );
          }
          
          // Track the closest clinic for fallback message
          if (result.distanceMeters != null) {
            if (closestDistance == null || result.distanceMeters! < closestDistance) {
              closestDistance = result.distanceMeters;
              closestClinicName = clinic.clinicName;
              bestResult = result;
            }
          }
        }
      }
      
      // No clinic was within verification range
      if (bestResult != null && closestDistance != null && closestClinicName != null) {
        return LocationVerificationResult(
          isVerified: false,
          distanceMeters: closestDistance,
          message: 'You are ${_formatDistance(closestDistance)} away from the closest clinic ($closestClinicName)',
        );
      } else {
        return LocationVerificationResult(
          isVerified: false,
          distanceMeters: null,
          message: 'No clinic locations available for verification',
        );
      }
    } catch (e) {
      dev.log('LocationService: Error in multi-clinic location verification: $e');
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

class AddressDetails {
  final String street;
  final String subLocality;
  final String locality;
  final String administrativeArea;
  final String postalCode;
  final String country;
  final String formattedAddress;

  const AddressDetails({
    required this.street,
    required this.subLocality,
    required this.locality,
    required this.administrativeArea,
    required this.postalCode,
    required this.country,
    required this.formattedAddress,
  });

  @override
  String toString() {
    return 'AddressDetails(formattedAddress: $formattedAddress)';
  }
}