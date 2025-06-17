// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../models/order_models.dart';

// --- UI Constants for easy theming and consistency ---
const _primaryColor = Color(0xFF4338CA); // A modern, deep indigo
const _successColor = Color(0xFF10B981); // A vibrant, clear green
const _dangerColor = Color(0xFFEF4444); // A standard, clear red
const _backgroundColor = Color(0xFFF3F4F6); // A light, neutral gray
const _cardBackgroundColor = Colors.white;
const _primaryTextColor = Color(0xFF1F2937);
const _secondaryTextColor = Color(0xFF6B7280);
const _borderColor = Color(0xFFE5E7EB);

class CombinedCustomerReviewSection extends StatefulWidget {
  final String customerName;
  final String notes;
  final List<CartItem> cartItems;
  final double totalAmount;
  final List<Map<String, dynamic>> stockValidationErrors;
  final Function(String) onCustomerNameChanged;
  final Function(String) onNotesChanged;
  final String? customerNameError;
  final bool isCreatingOrder;
  final VoidCallback onConfirmOrder;

  const CombinedCustomerReviewSection({
    super.key,
    required this.customerName,
    required this.notes,
    required this.cartItems,
    required this.totalAmount,
    required this.stockValidationErrors,
    required this.onCustomerNameChanged,
    required this.onNotesChanged,
    this.customerNameError,
    required this.isCreatingOrder,
    required this.onConfirmOrder,
  });

  @override
  State<CombinedCustomerReviewSection> createState() => _CombinedCustomerReviewSectionState();
}

class _CombinedCustomerReviewSectionState extends State<CombinedCustomerReviewSection> {
  bool _showOrderSummary = false;
  late TextEditingController _customerNameController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _customerNameController = TextEditingController(text: widget.customerName);
    _notesController = TextEditingController(text: widget.notes);
  }

  @override
  void didUpdateWidget(covariant CombinedCustomerReviewSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync controller text if the parent widget's state changes, e.g., from a quick select.
    if (widget.customerName != _customerNameController.text) {
      _customerNameController.text = widget.customerName;
    }
    if (widget.notes != _notesController.text) {
      _notesController.text = widget.notes;
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  int get totalItemsInCart {
    return widget.cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantityStrips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showOrderSummary
                    ? _buildOrderSummary()
                    : _buildCustomerForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: _cardBackgroundColor,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _showOrderSummary ? 'Review Order' : 'Customer Details',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _primaryTextColor,
            ),
          ),
          _buildToggle(),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton('Details', Icons.person_outline_rounded, !_showOrderSummary, () {
            if (_showOrderSummary) setState(() => _showOrderSummary = false);
          }),
          _buildToggleButton('Summary', Icons.receipt_long_outlined, _showOrderSummary, () {
            if (!_showOrderSummary) setState(() => _showOrderSummary = true);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? _primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : _secondaryTextColor, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : _secondaryTextColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Customer Name',
          icon: Icons.store_outlined,
          iconColor: _primaryColor,
          isOptional: false,
          child: TextFormField(
            controller: _customerNameController,
            onChanged: widget.onCustomerNameChanged,
            decoration: _inputDecoration(
              hintText: 'e.g., City Medical Store',
              errorText: widget.customerNameError,
            ),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textCapitalization: TextCapitalization.words,
            maxLength: 100,
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Quick Select',
          icon: Icons.speed_outlined,
          iconColor: Colors.orange.shade700,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _QuickSelectChip(
                label: "Dr. Sharma's Clinic",
                onTap: () => widget.onCustomerNameChanged("Dr. Sharma's Clinic"),
              ),
              _QuickSelectChip(
                label: 'Apollo Pharmacy',
                onTap: () => widget.onCustomerNameChanged('Apollo Pharmacy'),
              ),
              _QuickSelectChip(
                label: 'Health Plus',
                onTap: () => widget.onCustomerNameChanged('Health Plus'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Optional Notes',
          icon: Icons.edit_note_outlined,
          iconColor: _successColor,
          isOptional: true,
          child: TextFormField(
            controller: _notesController,
            onChanged: widget.onNotesChanged,
            decoration: _inputDecoration(
              hintText: 'Add delivery instructions, payment terms, etc.',
            ),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            maxLines: 4,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        if (widget.cartItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildQuickCartPreview(),
          const SizedBox(height: 20),
          // Review & Confirm Order Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.isCreatingOrder || widget.cartItems.isEmpty || widget.customerName.isEmpty
                  ? null
                  : () {
                      setState(() => _showOrderSummary = true);
                      // Small delay to allow animation, then trigger order creation
                      Future.delayed(const Duration(milliseconds: 300), () {
                        widget.onConfirmOrder();
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _successColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                disabledBackgroundColor: const Color(0xFFD1D5DB),
              ),
              child: widget.isCreatingOrder
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Creating Order...',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Review & Confirm Order (₹${widget.totalAmount.toStringAsFixed(2)})',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
    bool isOptional = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _primaryTextColor),
              ),
              const Spacer(),
              if (isOptional)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Optional', style: TextStyle(fontSize: 10, color: _secondaryTextColor, fontWeight: FontWeight.w500)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: _dangerColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Text('Required', style: TextStyle(fontSize: 10, color: _dangerColor, fontWeight: FontWeight.w500)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String hintText, String? errorText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _secondaryTextColor),
      errorText: errorText,
      filled: true,
      fillColor: _backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _dangerColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _dangerColor, width: 2.0),
      ),
      counterText: '', // Remove default counter
    );
  }

  Widget _buildQuickCartPreview() {
    return GestureDetector(
      onTap: () => setState(() => _showOrderSummary = true),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _primaryColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.shopping_cart_outlined, color: _primaryColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order Preview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryTextColor)),
                  Text('$totalItemsInCart items • ₹${widget.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, color: _primaryColor, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: _primaryColor, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Customer Details',
          icon: Icons.person_outline_rounded,
          iconColor: _primaryColor,
          child: Column(
            children: [
              _buildSummaryRow('Name', widget.customerName.isNotEmpty ? widget.customerName : 'Not specified'),
              if (widget.notes.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildSummaryRow('Notes', widget.notes),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Order Items (${widget.cartItems.length})',
          icon: Icons.inventory_2_outlined,
          iconColor: _successColor,
          child: Column(
            children: [
              ...widget.cartItems.map((item) => _buildItemSummaryCard(item)),
              const Divider(height: 24, color: _borderColor),
              _buildSummaryRow(
                'Total Amount',
                '₹${widget.totalAmount.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
        if (widget.stockValidationErrors.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildStockErrorCard(),
        ],
        const SizedBox(height: 20),
        // Confirm Order Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: widget.isCreatingOrder || widget.cartItems.isEmpty || widget.customerName.isEmpty
                ? null
                : widget.onConfirmOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: _successColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              disabledBackgroundColor: const Color(0xFFD1D5DB),
            ),
            child: widget.isCreatingOrder
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Creating Order...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Confirm Order (₹${widget.totalAmount.toStringAsFixed(2)})',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
        // Validation Messages
        if (widget.cartItems.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _dangerColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _dangerColor.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: _dangerColor,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Please add at least one item to your cart before confirming the order.',
                    style: TextStyle(
                      color: _dangerColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (widget.customerName.isEmpty && widget.cartItems.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  color: Color(0xFFF59E0B),
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Please enter a customer name before confirming the order.',
                    style: TextStyle(
                      color: Color(0xFFD97706),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: _secondaryTextColor,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              color: isTotal ? _successColor : _primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemSummaryCard(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w600, color: _primaryTextColor)),
                Text('Batch: ${item.batchNumber}', style: const TextStyle(fontSize: 12, color: _secondaryTextColor)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${item.quantityStrips} strips', style: const TextStyle(fontWeight: FontWeight.w600, color: _primaryTextColor)),
              Text('₹${(item.pricePerStrip * item.quantityStrips).toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, color: _secondaryTextColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockErrorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _dangerColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _dangerColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: _dangerColor, size: 20),
              const SizedBox(width: 8),
              const Text('Stock Issues Found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _dangerColor)),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.stockValidationErrors.map((error) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: _dangerColor, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    '${error['product_name']}: ${error['message']}',
                    style: const TextStyle(color: _dangerColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _QuickSelectChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickSelectChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _borderColor),
        ),
        child: Text(
          label,
          style: const TextStyle(color: _primaryColor, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}