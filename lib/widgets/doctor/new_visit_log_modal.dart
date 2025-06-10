// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/doctor/doctor_detail_cubit.dart';
import '../../bloc/doctor/doctor_state.dart';
import '../../models/doctor_models.dart';
import '../../services/location_service.dart';

class NewVisitLogModal extends StatefulWidget {
  final String doctorId;
  final Doctor doctor;
  final VoidCallback? onSuccess;

  const NewVisitLogModal({
    super.key,
    required this.doctorId,
    required this.doctor,
    this.onSuccess,
  });

  @override
  State<NewVisitLogModal> createState() => _NewVisitLogModalState();
}

class _NewVisitLogModalState extends State<NewVisitLogModal> {
  final _formKey = GlobalKey<FormState>();
  final _productsController = TextEditingController();
  final _feedbackController = TextEditingController();
  final _nextObjectiveController = TextEditingController();
  
  DateTime _visitDate = DateTime.now();
  DateTime? _nextVisitDate;
  
  late VisitLogCubit _visitLogCubit;
  
  // Location verification state
  bool _isVerifyingLocation = false;
  LocationVerificationResult? _locationResult;

  @override
  void initState() {
    super.initState();
    _visitLogCubit = VisitLogCubit();
    _startLocationVerification();
  }

  /// Start location verification process
  Future<void> _startLocationVerification() async {
    setState(() {
      _isVerifyingLocation = true;
    });

    try {
      final result = await LocationService.performLocationVerification(
        widget.doctor.latitude,
        widget.doctor.longitude,
      );
      
      setState(() {
        _locationResult = result;
        _isVerifyingLocation = false;
      });
    } catch (e) {
      setState(() {
        _locationResult = LocationVerificationResult(
          isVerified: false,
          distanceMeters: null,
          message: 'Location verification failed',
        );
        _isVerifyingLocation = false;
      });
    }
  }

  @override
  void dispose() {
    _productsController.dispose();
    _feedbackController.dispose();
    _nextObjectiveController.dispose();
    _visitLogCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _visitLogCubit,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return BlocListener<VisitLogCubit, VisitLogState>(
              listener: (context, state) {
                if (state is VisitLogSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Visit logged successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop(true);
                } else if (state is VisitLogError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildLocationVerificationCard(),
                          const SizedBox(height: 20),
                          _buildForm(),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomActions(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Log New Visit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationVerificationCard() {
    if (_isVerifyingLocation) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Verifying location...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      );
    }

    if (_locationResult == null) {
      return const SizedBox.shrink();
    }

    final isVerified = _locationResult!.isVerified;
    final color = isVerified ? Colors.green : Colors.orange;
    final icon = isVerified ? Icons.check_circle : Icons.warning;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isVerified ? 'Location Verified' : 'Location Not Verified',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _locationResult!.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _startLocationVerification,
            icon: Icon(
              Icons.refresh,
              color: color,
              size: 18,
            ),
            tooltip: 'Refresh location',
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateField(
            label: 'Visit Date',
            value: _visitDate,
            onTap: () => _selectDate(context, true),
            isRequired: true,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _productsController,
            label: 'Products Discussed',
            hint: 'Enter products discussed during the visit',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _feedbackController,
            label: 'Feedback & Notes',
            hint: 'Enter feedback received and visit notes',
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          _buildDateField(
            label: 'Next Visit Date (Optional)',
            value: _nextVisitDate,
            onTap: () => _selectDate(context, false),
            isRequired: false,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _nextObjectiveController,
            label: 'Next Visit Objective (Optional)',
            hint: 'Enter objective for the next visit',
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[700]!),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    required bool isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value != null
                        ? DateFormat('MMM dd, yyyy').format(value)
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 16,
                      color: value != null ? Colors.black87 : Colors.grey[500],
                    ),
                  ),
                ),
                if (value != null && !isRequired)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (!isRequired) {
                          _nextVisitDate = null;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[400]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: BlocBuilder<VisitLogCubit, VisitLogState>(
              builder: (context, state) {
                final isLoading = state is VisitLogLoading;
                
                return ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Save Visit Log',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isVisitDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isVisitDate ? _visitDate : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[700]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isVisitDate) {
          _visitDate = picked;
        } else {
          _nextVisitDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = CreateVisitLogRequest(
        doctorId: widget.doctorId,
        visitDate: _visitDate,
        productsDetailed: _productsController.text.trim().isNotEmpty
            ? _productsController.text.trim()
            : null,
        feedbackReceived: _feedbackController.text.trim().isNotEmpty
            ? _feedbackController.text.trim()
            : null,
        nextVisitDate: _nextVisitDate,
        nextVisitObjective: _nextObjectiveController.text.trim().isNotEmpty
            ? _nextObjectiveController.text.trim()
            : null,
        isLocationVerified: _locationResult?.isVerified,
        distanceFromClinicMeters: _locationResult?.distanceMeters,
      );

      _visitLogCubit.createVisitLog(request);
    }
  }
}