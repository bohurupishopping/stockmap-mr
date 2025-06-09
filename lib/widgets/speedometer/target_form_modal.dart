import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/target_models.dart';
import '../../bloc/speedometer/speedometer_cubit.dart';

class TargetFormModal extends StatefulWidget {
  final String period;

  const TargetFormModal({
    super.key,
    required this.period,
  });

  @override
  State<TargetFormModal> createState() => _TargetFormModalState();
}

class _TargetFormModalState extends State<TargetFormModal> {
  final _formKey = GlobalKey<FormState>();
  final _mainGoalController = TextEditingController();
  final _bronzeGoalController = TextEditingController();
  final _goldGoalController = TextEditingController();
  final _collectionController = TextEditingController();
  final _focusUnitsController = TextEditingController();
  final _focusAmountController = TextEditingController();

  bool _showAdvanced = false;
  bool _showFocusGoal = false;
  String? _selectedProductId;
  String? _selectedProductName;
  List<Map<String, dynamic>> _availableProducts = [];
  bool _isLoadingProducts = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableProducts();
  }

  @override
  void dispose() {
    _mainGoalController.dispose();
    _bronzeGoalController.dispose();
    _goldGoalController.dispose();
    _collectionController.dispose();
    _focusUnitsController.dispose();
    _focusAmountController.dispose();
    super.dispose();
  }

  Future<void> _loadAvailableProducts() async {
    setState(() => _isLoadingProducts = true);
    try {
      final products = await context.read<SpeedometerCubit>().getAvailableProducts();
      setState(() {
        _availableProducts = products;
        _isLoadingProducts = false;
      });
    } catch (e) {
      setState(() => _isLoadingProducts = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                controller: scrollController,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Set Your Goal for ${widget.period}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Main Goal (Required)
                  Text(
                    'Main Goal (Required)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mainGoalController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Target Sales Amount',
                      prefixText: '₹ ',
                      hintText: '50,000',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your target sales amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Advanced Goals (Optional)
                  Card(
                    child: ExpansionTile(
                      title: const Text('Advanced Goals (Optional)'),
                      leading: const Icon(Icons.tune),
                      initiallyExpanded: _showAdvanced,
                      onExpansionChanged: (expanded) {
                        setState(() => _showAdvanced = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Tier Goals
                              Text(
                                'Set Tier Goals',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _bronzeGoalController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'Bronze Goal',
                                        prefixText: '₹ ',
                                        hintText: '30,000',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _goldGoalController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'Gold Goal',
                                        prefixText: '₹ ',
                                        hintText: '75,000',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Collection Goal
                              Text(
                                'Collection Target',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _collectionController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Target Collection Percentage',
                                  suffixText: '%',
                                  hintText: '95',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final percentage = double.tryParse(value);
                                    if (percentage == null || percentage < 0 || percentage > 100) {
                                      return 'Please enter a valid percentage (0-100)';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Focus Goal (Optional)
                  Card(
                    child: ExpansionTile(
                      title: const Text('Add a Focus Goal (Optional)'),
                      leading: const Icon(Icons.center_focus_strong),
                      initiallyExpanded: _showFocusGoal,
                      onExpansionChanged: (expanded) {
                        setState(() => _showFocusGoal = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select a product to focus on',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (_isLoadingProducts)
                                const Center(child: CircularProgressIndicator())
                              else
                                DropdownButtonFormField<String>(
                                  value: _selectedProductId,
                                  decoration: const InputDecoration(
                                    labelText: 'Select Product',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: _availableProducts.map((product) {
                                    return DropdownMenuItem<String>(
                                      value: product['id'],
                                      child: Text(
                                        '${product['name']} - ${product['manufacturer']}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProductId = value;
                                      _selectedProductName = _availableProducts
                                          .firstWhere((p) => p['id'] == value)['name'];
                                    });
                                  },
                                ),
                              if (_selectedProductId != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  'Set your goal for $_selectedProductName',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _focusUnitsController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: 'Target Units',
                                          hintText: '500',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _focusAmountController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: 'Target Amount',
                                          prefixText: '₹ ',
                                          hintText: '25,000',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Set My Goal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = TargetFormData(
        mainGoal: double.parse(_mainGoalController.text),
        bronzeGoal: _bronzeGoalController.text.isNotEmpty
            ? double.parse(_bronzeGoalController.text)
            : 0.0,
        goldGoal: _goldGoalController.text.isNotEmpty
            ? double.parse(_goldGoalController.text)
            : 0.0,
        collectionPercentage: _collectionController.text.isNotEmpty
            ? double.parse(_collectionController.text)
            : 0.0,
        focusProductId: _selectedProductId,
        focusProductName: _selectedProductName,
        focusGoalUnits: _focusUnitsController.text.isNotEmpty
            ? int.parse(_focusUnitsController.text)
            : 0,
        focusGoalAmount: _focusAmountController.text.isNotEmpty
            ? double.parse(_focusAmountController.text)
            : 0.0,
      );

      context.read<SpeedometerCubit>().createTarget(formData, widget.period);
      Navigator.pop(context);
    }
  }
}