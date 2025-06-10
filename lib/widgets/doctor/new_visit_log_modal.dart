// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/doctor/doctor_detail_cubit.dart';
import '../../bloc/doctor/doctor_state.dart';
import '../../models/doctor_models.dart';
import '../../models/product_models.dart';
import '../../services/location_service.dart';
import '../../services/product_service.dart';

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
  final _samplesController = TextEditingController();
  final _competitorNotesController = TextEditingController();
  final _prescriptionNotesController = TextEditingController();
  
  DateTime _visitDate = DateTime.now();
  DateTime? _nextVisitDate;
  
  late VisitLogCubit _visitLogCubit;
  
  // Location verification state
  bool _isVerifyingLocation = false;
  LocationVerificationResult? _locationResult;
  
  // Product selection state
  List<Product> _availableProducts = [];
  final List<Product> _selectedProducts = [];
  bool _isLoadingProducts = false;

  // Modern color scheme
  static const Color _accentColor = Color(0xFF3B82F6);
  static const Color _successColor = Color(0xFF10B981);
  static const Color _warningColor = Color(0xFFF59E0B);
  static const Color _errorColor = Color(0xFFEF4444);
  static const Color _surfaceColor = Color(0xFFF8FAFC);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF0F172A);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _borderColor = Color(0xFFE2E8F0);

  @override
  void initState() {
    super.initState();
    _visitLogCubit = VisitLogCubit();
    _startLocationVerification();
    _loadProducts();
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

  /// Load available products for selection
  Future<void> _loadProducts() async {
    setState(() {
      _isLoadingProducts = true;
    });

    try {
      final result = await ProductService.getProducts(
        filters: ProductFilters(isActive: true),
        limit: 100,
        includeStock: false,
      );
      
      setState(() {
        _availableProducts = result['products'] as List<Product>;
        _isLoadingProducts = false;
      });
    } catch (e) {
      setState(() {
        _availableProducts = [];
        _isLoadingProducts = false;
      });
    }
  }

  @override
  void dispose() {
    _productsController.dispose();
    _feedbackController.dispose();
    _nextObjectiveController.dispose();
    _samplesController.dispose();
    _competitorNotesController.dispose();
    _prescriptionNotesController.dispose();
    _visitLogCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _visitLogCubit,
      child: Container(
        decoration: const BoxDecoration(
          color: _surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.92,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return BlocListener<VisitLogCubit, VisitLogState>(
              listener: (context, state) {
                if (state is VisitLogSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('Visit logged successfully!'),
                        ],
                      ),
                      backgroundColor: _successColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                  Navigator.of(context).pop(true);
                } else if (state is VisitLogError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Error: ${state.message}')),
                        ],
                      ),
                      backgroundColor: _errorColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      decoration: const BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          bottom: BorderSide(color: _borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.add_chart_outlined,
              color: _accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Log New Visit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close_rounded,
                  color: _textSecondary,
                  size: 20,
                ),
              ),
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
          color: _cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _accentColor.withOpacity(0.2)),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Verifying location...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
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
    final color = isVerified ? _successColor : _warningColor;
    final icon = isVerified ? Icons.check_circle_outline : Icons.warning_amber_outlined;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
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
                  style: const TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _startLocationVerification,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  Icons.refresh_rounded,
                  color: color,
                  size: 16,
                ),
              ),
            ),
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
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 18),
          _buildProductSelectionField(),
          const SizedBox(height: 18),
          _buildTextField(
            controller: _feedbackController,
            label: 'Feedback & Notes',
            hint: 'Enter feedback received and visit notes',
            maxLines: 4,
            icon: Icons.comment_outlined,
          ),
          const SizedBox(height: 18),
          _buildTextField(
            controller: _samplesController,
            label: 'Samples Provided',
            hint: 'Enter details of samples provided',
            maxLines: 2,
            icon: Icons.medical_services_outlined,
          ),
          const SizedBox(height: 18),
          _buildTextField(
            controller: _competitorNotesController,
            label: 'Competitor Activity Notes',
            hint: 'Enter any competitor activity observed',
            maxLines: 3,
            icon: Icons.business_outlined,
          ),
          const SizedBox(height: 18),
          _buildTextField(
            controller: _prescriptionNotesController,
            label: 'Prescription Potential Notes',
            hint: 'Enter notes about prescription potential',
            maxLines: 3,
            icon: Icons.receipt_long_outlined,
          ),
          const SizedBox(height: 18),
          _buildDateField(
            label: 'Next Visit Date',
            value: _nextVisitDate,
            onTap: () => _selectDate(context, false),
            isRequired: false,
            icon: Icons.event_outlined,
          ),
          const SizedBox(height: 18),
          _buildTextField(
            controller: _nextObjectiveController,
            label: 'Next Visit Objective',
            hint: 'Enter objective for the next visit',
            maxLines: 2,
            icon: Icons.flag_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildProductSelectionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.inventory_2_outlined, size: 16, color: _textSecondary),
            const SizedBox(width: 8),
            const Text(
              'Products Discussed',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(12),
            color: _cardColor,
          ),
          child: Column(
            children: [
              // Product selection button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isLoadingProducts ? null : _showProductSelectionDialog,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: 18,
                          color: _isLoadingProducts ? _textSecondary : _accentColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _isLoadingProducts
                                ? 'Loading products...'
                                : 'Select Products',
                            style: TextStyle(
                              fontSize: 15,
                              color: _isLoadingProducts ? _textSecondary : _accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (_isLoadingProducts)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(_textSecondary),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // Selected products list
              if (_selectedProducts.isNotEmpty) ...
              [
                const Divider(height: 1, color: _borderColor),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Products (${_selectedProducts.length})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _selectedProducts.map((product) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _accentColor.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  product.productName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _accentColor,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedProducts.remove(product);
                                      _updateProductsController();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: _accentColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ],
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
    int maxLines = 1,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: _textSecondary),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                  letterSpacing: -0.2,
                ),
                children: [
                  if (isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: _errorColor),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 15,
            color: _textPrimary,
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: _textSecondary,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _accentColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _errorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _errorColor, width: 2),
            ),
            filled: true,
            fillColor: _cardColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 14,
            ),
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
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: _textSecondary),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                  letterSpacing: -0.2,
                ),
                children: [
                  if (isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: _errorColor),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Material(
          color: _cardColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: _borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: _textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value != null
                          ? DateFormat('MMM dd, yyyy').format(value)
                          : 'Select date',
                      style: TextStyle(
                        fontSize: 15,
                        color: value != null ? _textPrimary : _textSecondary,
                        fontWeight: value != null ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (value != null && !isRequired)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (!isRequired) {
                              _nextVisitDate = null;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.clear_rounded,
                            size: 16,
                            color: _textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: _cardColor,
        border: Border(
          top: BorderSide(color: _borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  foregroundColor: _textSecondary,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: BlocBuilder<VisitLogCubit, VisitLogState>(
                builder: (context, state) {
                  final isLoading = state is VisitLogLoading;
                  
                  return ElevatedButton(
                    onPressed: isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: _textSecondary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save_outlined, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Save Visit Log',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
          ],
        ),
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
            colorScheme: const ColorScheme.light(
              primary: _accentColor,
              onPrimary: Colors.white,
              surface: _cardColor,
              onSurface: _textPrimary,
              secondary: _accentColor,
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              headerBackgroundColor: _accentColor,
              headerForegroundColor: Colors.white,
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

  void _showProductSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Products'),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: _availableProducts.isEmpty
                    ? const Center(
                        child: Text('No products available'),
                      )
                    : ListView.builder(
                        itemCount: _availableProducts.length,
                        itemBuilder: (context, index) {
                          final product = _availableProducts[index];
                          final isSelected = _selectedProducts.contains(product);
                          return CheckboxListTile(
                            title: Text(product.productName),
                            subtitle: Text(product.genericName),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setDialogState(() {
                                if (value == true) {
                                  _selectedProducts.add(product);
                                } else {
                                  _selectedProducts.remove(product);
                                }
                              });
                            },
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _updateProductsController();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateProductsController() {
    final productNames = _selectedProducts.map((p) => p.productName).join(', ');
    _productsController.text = productNames;
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
        samplesProvided: _samplesController.text.trim().isNotEmpty
            ? _samplesController.text.trim()
            : null,
        competitorActivityNotes: _competitorNotesController.text.trim().isNotEmpty
            ? _competitorNotesController.text.trim()
            : null,
        prescriptionPotentialNotes: _prescriptionNotesController.text.trim().isNotEmpty
            ? _prescriptionNotesController.text.trim()
            : null,
      );

      _visitLogCubit.createVisitLog(request);
    }
  }
}