// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/doctor_models.dart';
import 'edit_clinic_modal.dart';

class NewDoctorForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final Function(String doctorId)? onDoctorCreated; // Callback when doctor is created successfully
  final VoidCallback? onCancel;

  const NewDoctorForm({
    super.key,
    required this.onSubmit,
    this.onDoctorCreated,
    this.onCancel,
  });

  @override
  State<NewDoctorForm> createState() => _NewDoctorFormState();
}

class _NewDoctorFormState extends State<NewDoctorForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  
  DateTime? _dateOfBirth;
  DateTime? _anniversaryDate;
  DoctorTier? _selectedTier;
  String? _selectedSpecialty;
  bool _isLoading = false;

  // Predefined specialty options
  static const List<String> _specialtyOptions = [
    'Cardiologist',
    'Dermatologist',
    'Endocrinologist',
    'Gastroenterologist',
    'General Practitioner',
    'Gynecologist',
    'Neurologist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedic Surgeon',
    'Pediatrician',
    'Psychiatrist',
    'Pulmonologist',
    'Radiologist',
    'Surgeon',
    'Urologist',
    'Other',
  ];

  // Modern color scheme
  static const Color _primaryColor = Color(0xFF2563EB); // Modern blue
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light gray
  static const Color _textPrimary = Color(0xFF1E293B); // Dark slate
  static const Color _textSecondary = Color(0xFF64748B); // Medium slate
  static const Color _borderColor = Color(0xFFE2E8F0); // Light border
  static const Color _successColor = Color(0xFF059669); // Modern green
  static const Color _warningColor = Color(0xFFD97706); // Modern orange
  static const Color _errorColor = Color(0xFFDC2626); // Modern red

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 32,
        vertical: isSmallScreen ? 24 : 32,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 720,
          maxHeight: screenSize.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildHeader(isSmallScreen),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 20 : 32,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBasicInfoSection(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 20 : 28),
                      _buildContactInfoSection(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 20 : 28),
                      _buildPersonalInfoSection(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 16 : 24),
                    ],
                  ),
                ),
              ),
            ),
            _buildActionButtons(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 32,
        vertical: isSmallScreen ? 16 : 24,
      ),
      decoration: const BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_add_rounded,
              color: _primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Add New Doctor',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
            color: _textSecondary,
            iconSize: 20,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Information', Icons.info_outline_rounded),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          hint: 'Enter doctor\'s full name',
          icon: Icons.person_outline_rounded,
          isRequired: true,
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Full name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildSpecialtyDropdown(),
        const SizedBox(height: 16),
        _buildTierDropdown(),
      ],
    );
  }

  Widget _buildContactInfoSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Information', Icons.contact_phone_outlined),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildTextField(
          controller: _phoneNumberController,
          label: 'Phone Number',
          hint: '+91 98765 43210',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'^[+]?[0-9\s\-\(\)]+$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'doctor@example.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information', Icons.calendar_today_outlined),
        SizedBox(height: isSmallScreen ? 12 : 16),
        isSmallScreen
            ? Column(
                children: [
                  _buildDateField(
                    label: 'Date of Birth',
                    value: _dateOfBirth,
                    onTap: () => _selectDate(context, true),
                    icon: Icons.cake_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(
                    label: 'Anniversary Date',
                    value: _anniversaryDate,
                    onTap: () => _selectDate(context, false),
                    icon: Icons.favorite_outline_rounded,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      label: 'Date of Birth',
                      value: _dateOfBirth,
                      onTap: () => _selectDate(context, true),
                      icon: Icons.cake_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                      label: 'Anniversary Date',
                      value: _anniversaryDate,
                      onTap: () => _selectDate(context, false),
                      icon: Icons.favorite_outline_rounded,
                    ),
                  ),
                ],
              ),
      ],
    );
  }




  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: _primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }




  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        fontSize: 14,
        color: _textPrimary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 18, color: _textSecondary),
        labelStyle: const TextStyle(
          color: _textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: _textSecondary.withOpacity(0.7),
          fontSize: 13,
        ),
        filled: true,
        fillColor: _surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildTierDropdown() {
    return DropdownButtonFormField<DoctorTier>(
      value: _selectedTier,
      style: const TextStyle(
        fontSize: 14,
        color: _textPrimary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: 'Doctor Tier',
        prefixIcon: const Icon(Icons.star_outline_rounded, size: 18, color: _textSecondary),
        labelStyle: const TextStyle(
          color: _textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: _surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: DoctorTier.values.map((tier) {
        String label;
        String description;
        Color color;
        
        switch (tier) {
          case DoctorTier.a:
            label = 'Tier A';
            description = 'High Potential';
            color = _successColor;
            break;
          case DoctorTier.b:
            label = 'Tier B';
            description = 'Medium Potential';
            color = _warningColor;
            break;
          case DoctorTier.c:
            label = 'Tier C';
            description = 'Low Potential';
            color = _errorColor;
            break;
        }
        
        return DropdownMenuItem(
          value: tier,
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color.withOpacity(0.3), width: 1),
                ),
                child: Center(
                  child: Text(
                    tier.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedTier = value;
        });
      },
    );
  }

  Widget _buildSpecialtyDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSpecialty,
      style: const TextStyle(
        fontSize: 14,
        color: _textPrimary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: 'Specialty',
        prefixIcon: const Icon(Icons.medical_services_outlined, size: 18, color: _textSecondary),
        labelStyle: const TextStyle(
          color: _textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: _surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: _specialtyOptions.map((specialty) {
        return DropdownMenuItem(
          value: specialty,
          child: Text(
            specialty,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _textPrimary,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedSpecialty = value;
        });
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: _textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value != null
                        ? '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}'
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: value != null ? _textPrimary : _textSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: _textSecondary.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 32,
        vertical: isSmallScreen ? 16 : 24,
      ),
      decoration: const BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : (widget.onCancel ?? () => Navigator.of(context).pop()),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: _borderColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: _textSecondary,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Add Doctor',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDateOfBirth) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDateOfBirth
          ? (_dateOfBirth ?? DateTime.now().subtract(const Duration(days: 365 * 30)))
          : (_anniversaryDate ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: _textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isDateOfBirth) {
          _dateOfBirth = picked;
        } else {
          _anniversaryDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Prepare the doctor data for the doctors table
    final doctorData = <String, dynamic>{
      'full_name': _fullNameController.text.trim(),
    };

    // Add optional fields only if they have values
    if (_selectedSpecialty != null && _selectedSpecialty!.isNotEmpty) {
      doctorData['specialty'] = _selectedSpecialty;
    }
    
    if (_phoneNumberController.text.trim().isNotEmpty) {
      doctorData['phone_number'] = _phoneNumberController.text.trim();
    }
    
    if (_emailController.text.trim().isNotEmpty) {
      doctorData['email'] = _emailController.text.trim();
    }
    
    if (_dateOfBirth != null) {
      doctorData['date_of_birth'] = _dateOfBirth!.toIso8601String();
    }
    
    if (_anniversaryDate != null) {
      doctorData['anniversary_date'] = _anniversaryDate!.toIso8601String();
    }
    
    if (_selectedTier != null) {
      doctorData['tier'] = _selectedTier!.name.toUpperCase();
    }

    // Call the submit callback with doctor data only
    widget.onSubmit(doctorData);
  }

  // Method to show clinic modal after doctor creation
  void showClinicModal(String doctorId) {
    // Reset loading state
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EditClinicModal(
        doctorId: doctorId,
        clinic: null, // null for adding new clinic
        onClinicUpdated: () {
          // Close the clinic modal and then close the doctor form
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  // Method to reset loading state in case of error
  void resetLoadingState() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}