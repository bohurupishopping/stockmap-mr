import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctor_models.dart';

class NewDoctorForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback? onCancel;

  const NewDoctorForm({
    super.key,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<NewDoctorForm> createState() => _NewDoctorFormState();
}

class _NewDoctorFormState extends State<NewDoctorForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _clinicAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  
  DateTime? _dateOfBirth;
  DateTime? _anniversaryDate;
  DoctorTier? _selectedTier;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _specialtyController.dispose();
    _clinicAddressController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBasicInfoSection(),
                      const SizedBox(height: 24),
                      _buildContactInfoSection(),
                      const SizedBox(height: 24),
                      _buildPersonalInfoSection(),
                      const SizedBox(height: 24),
                      _buildLocationSection(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.person_add,
          color: Colors.blue[700],
          size: 28,
        ),
        const SizedBox(width: 12),
        const Text(
          'Add New Doctor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
          color: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Information'),
        const SizedBox(height: 16),
        TextFormField(
          controller: _fullNameController,
          decoration: const InputDecoration(
            labelText: 'Full Name *',
            hintText: 'Enter doctor\'s full name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Full name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _specialtyController,
          decoration: const InputDecoration(
            labelText: 'Specialty',
            hintText: 'e.g., Cardiologist, Pediatrician',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.medical_services),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<DoctorTier>(
          value: _selectedTier,
          decoration: const InputDecoration(
            labelText: 'Doctor Tier',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.star),
          ),
          items: DoctorTier.values.map((tier) {
            String label;
            String description;
            Color color;
            
            switch (tier) {
              case DoctorTier.a:
                label = 'Tier A';
                description = 'High Potential';
                color = Colors.green;
                break;
              case DoctorTier.b:
                label = 'Tier B';
                description = 'Medium Potential';
                color = Colors.orange;
                break;
              case DoctorTier.c:
                label = 'Tier C';
                description = 'Low Potential';
                color = Colors.red;
                break;
            }
            
            return DropdownMenuItem(
              value: tier,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: color),
                    ),
                    child: Center(
                      child: Text(
                        tier.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                      Text(label),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Information'),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '+1 234 567 8900',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              // Basic phone validation
              if (!RegExp(r'^[+]?[0-9\s\-\(\)]+$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'doctor@example.com',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
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
        const SizedBox(height: 16),
        TextFormField(
          controller: _clinicAddressController,
          decoration: const InputDecoration(
            labelText: 'Clinic Address',
            hintText: 'Enter clinic address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          maxLines: 2,
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                label: 'Date of Birth',
                value: _dateOfBirth,
                onTap: () => _selectDate(context, true),
                icon: Icons.cake,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateField(
                label: 'Anniversary Date',
                value: _anniversaryDate,
                onTap: () => _selectDate(context, false),
                icon: Icons.favorite,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Location (Optional)'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  hintText: '40.7128',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.my_location),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final lat = double.tryParse(value);
                    if (lat == null || lat < -90 || lat > 90) {
                      return 'Invalid latitude';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  hintText: '-74.0060',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.place),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final lng = double.tryParse(value);
                    if (lng == null || lng < -180 || lng > 180) {
                      return 'Invalid longitude';
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.blue[700],
      ),
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
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          value != null
              ? '${value.day}/${value.month}/${value.year}'
              : 'Select date',
          style: TextStyle(
            color: value != null ? Colors.black87 : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : (widget.onCancel ?? () => Navigator.of(context).pop()),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Add Doctor'),
          ),
        ),
      ],
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
            colorScheme: ColorScheme.light(
              primary: Colors.blue[700]!,
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

    // Prepare the data
    final doctorData = <String, dynamic>{
      'full_name': _fullNameController.text.trim(),
    };

    // Add optional fields only if they have values
    if (_specialtyController.text.trim().isNotEmpty) {
      doctorData['specialty'] = _specialtyController.text.trim();
    }
    
    if (_clinicAddressController.text.trim().isNotEmpty) {
      doctorData['clinic_address'] = _clinicAddressController.text.trim();
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
    
    if (_latitudeController.text.trim().isNotEmpty) {
      doctorData['latitude'] = double.tryParse(_latitudeController.text.trim());
    }
    
    if (_longitudeController.text.trim().isNotEmpty) {
      doctorData['longitude'] = double.tryParse(_longitudeController.text.trim());
    }

    // Call the submit callback
    widget.onSubmit(doctorData);
  }
}