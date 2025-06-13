import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/doctor/doctor_detail_cubit.dart';
import '../../models/doctor_clinic_models.dart';
import '../../services/location_service.dart';

class EditClinicModal extends StatefulWidget {
  final String doctorId;
  final DoctorClinic? clinic; // null for adding new clinic
  final VoidCallback onClinicUpdated;

  const EditClinicModal({
    super.key,
    required this.doctorId,
    this.clinic,
    required this.onClinicUpdated,
  });

  @override
  State<EditClinicModal> createState() => _EditClinicModalState();
}

class _EditClinicModalState extends State<EditClinicModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _clinicNameController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  
  bool _isPrimary = false;
  bool _isLoading = false;
  AddressDetails? _addressDetails;
  bool _isLoadingAddress = false;

  bool get isEditing => widget.clinic != null;

  @override
  void initState() {
    super.initState();
    _clinicNameController = TextEditingController(text: widget.clinic?.clinicName ?? '');
    _latitudeController = TextEditingController(
      text: widget.clinic?.latitude?.toString() ?? '',
    );
    _longitudeController = TextEditingController(
      text: widget.clinic?.longitude?.toString() ?? '',
    );
    _isPrimary = widget.clinic?.isPrimary ?? false;
    
    // Add listeners to coordinate fields to update address when changed
    _latitudeController.addListener(_onCoordinatesChanged);
    _longitudeController.addListener(_onCoordinatesChanged);
    
    // Auto-fetch location for new clinics
    if (!isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchCurrentLocation();
      });
    } else {
      // Fetch address for existing clinic coordinates
      if (widget.clinic?.latitude != null && widget.clinic?.longitude != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fetchAddressFromCoordinates(widget.clinic!.latitude!, widget.clinic!.longitude!);
        });
      }
    }
  }

  @override
  void dispose() {
    _latitudeController.removeListener(_onCoordinatesChanged);
    _longitudeController.removeListener(_onCoordinatesChanged);
    _clinicNameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _onCoordinatesChanged() {
    final latText = _latitudeController.text.trim();
    final lonText = _longitudeController.text.trim();
    
    if (latText.isNotEmpty && lonText.isNotEmpty) {
      final lat = double.tryParse(latText);
      final lon = double.tryParse(lonText);
      
      if (lat != null && lon != null && lat >= -90 && lat <= 90 && lon >= -180 && lon <= 180) {
        // Debounce the address fetching to avoid too many API calls
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && 
              _latitudeController.text.trim() == latText && 
              _longitudeController.text.trim() == lonText) {
            _fetchAddressFromCoordinates(lat, lon);
          }
        });
      } else {
        // Clear address if coordinates are invalid
        if (mounted) {
          setState(() {
            _addressDetails = null;
          });
        }
      }
    } else {
      // Clear address if coordinates are empty
      if (mounted) {
        setState(() {
          _addressDetails = null;
        });
      }
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      // Request location permission
      final hasPermission = await LocationService.requestLocationPermission();
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission is required to fetch current location'),
              backgroundColor: Color(0xFFEF4444),
            ),
          );
        }
        return;
      }

      // Get current location
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        _latitudeController.text = position.latitude.toStringAsFixed(6);
        _longitudeController.text = position.longitude.toStringAsFixed(6);
        
        // Fetch address details for the current location
        await _fetchAddressFromCoordinates(position.latitude, position.longitude);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Current location fetched successfully'),
              backgroundColor: Color(0xFF059669),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to get current location. Please try again.'),
              backgroundColor: Color(0xFFEF4444),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching location: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  Future<void> _fetchAddressFromCoordinates(double latitude, double longitude) async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingAddress = true;
    });

    try {
      final addressDetails = await LocationService.getAddressFromCoordinates(latitude, longitude);
      if (mounted) {
        setState(() {
          _addressDetails = addressDetails;
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _addressDetails = null;
          _isLoadingAddress = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: isTablet ? 500 : double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEditing ? Icons.edit_location_rounded : Icons.add_location_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEditing ? 'Edit Clinic Location' : 'Add Clinic Location',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Form content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _clinicNameController,
                        label: 'Clinic Name',
                        icon: Icons.local_hospital_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the clinic name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Location coordinates section with auto-fetch button
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF2563EB),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Clinic Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _latitudeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Latitude',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter latitude';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: _longitudeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Longitude',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter longitude';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Address display section
                            if (_isLoadingAddress || _addressDetails != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: _isLoadingAddress
                                    ? const Row(
                                        children: [
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Fetching address...',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      )
                                    : _addressDetails != null
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.place_rounded,
                                                    size: 16,
                                                    color: Color(0xFF059669),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Text(
                                                    'Address:',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF1E293B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                _addressDetails!.formattedAddress.isNotEmpty
                                                    ? _addressDetails!.formattedAddress
                                                    : 'Address not available',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF64748B),
                                                  height: 1.4,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                              ),
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPrimarySwitch(),
                      const SizedBox(height: 8),
                      const Text(
                        'Set as primary clinic location for this doctor',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Action buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveClinic,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              isEditing ? 'Update Clinic' : 'Add Clinic',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2563EB)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
      ),
    );
  }

  Widget _buildPrimarySwitch() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star_rounded,
            color: Color(0xFF2563EB),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Primary Clinic',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          Switch(
            value: _isPrimary,
            onChanged: (value) => setState(() => _isPrimary = value),
            activeColor: const Color(0xFF2563EB),
          ),
        ],
      ),
    );
  }

  Future<void> _saveClinic() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final latitude = double.parse(_latitudeController.text.trim());
      final longitude = double.parse(_longitudeController.text.trim());
      
      if (isEditing) {
        // Update existing clinic
        final updateRequest = UpdateDoctorClinicRequest(
          clinicName: _clinicNameController.text.trim(),
          latitude: latitude,
          longitude: longitude,
          isPrimary: _isPrimary,
        );
        
        await context.read<DoctorDetailCubit>().updateClinic(
          widget.clinic!.id,
          widget.doctorId,
          updateRequest,
        );
      } else {
        // Create new clinic
        final createRequest = CreateDoctorClinicRequest(
          doctorId: widget.doctorId,
          clinicName: _clinicNameController.text.trim(),
          latitude: latitude,
          longitude: longitude,
          isPrimary: _isPrimary,
        );
        
        await context.read<DoctorDetailCubit>().createClinic(createRequest);
      }
      
      if (mounted) {
        Navigator.of(context).pop();
        widget.onClinicUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing 
                  ? 'Clinic updated successfully'
                  : 'Clinic added successfully',
            ),
            backgroundColor: const Color(0xFF059669),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing 
                  ? 'Error updating clinic: $e'
                  : 'Error adding clinic: $e',
            ),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}