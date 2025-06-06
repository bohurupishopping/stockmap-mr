import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/order_models.dart';

class QuantityInputDialog extends StatefulWidget {
  final MrStockItem stockItem;
  final Function(int) onConfirm;

  const QuantityInputDialog({
    super.key,
    required this.stockItem,
    required this.onConfirm,
  });

  @override
  State<QuantityInputDialog> createState() => _QuantityInputDialogState();
}

class _QuantityInputDialogState extends State<QuantityInputDialog> {
  final TextEditingController _cartonsController = TextEditingController();
  final TextEditingController _boxesController = TextEditingController();
  final TextEditingController _stripsController = TextEditingController();
  final TextEditingController _totalStripsController = TextEditingController();
  
  bool _isDirectStripInput = false;
  int _totalStrips = 0;
  
  @override
  void initState() {
    super.initState();
    _updateTotalStrips();
  }

  @override
  void dispose() {
    _cartonsController.dispose();
    _boxesController.dispose();
    _stripsController.dispose();
    _totalStripsController.dispose();
    super.dispose();
  }

  void _updateTotalStrips() {
    final cartons = int.tryParse(_cartonsController.text) ?? 0;
    final boxes = int.tryParse(_boxesController.text) ?? 0;
    final strips = int.tryParse(_stripsController.text) ?? 0;
    
    final stripsPerCarton = widget.stockItem.boxesPerCarton * widget.stockItem.stripsPerBox;
    final stripsFromCartons = cartons * stripsPerCarton;
    final stripsFromBoxes = boxes * widget.stockItem.stripsPerBox;
    
    setState(() {
      _totalStrips = stripsFromCartons + stripsFromBoxes + strips;
      if (!_isDirectStripInput) {
        _totalStripsController.text = _totalStrips.toString();
      }
    });
  }

  void _updateFromTotalStrips() {
    final totalStrips = int.tryParse(_totalStripsController.text) ?? 0;
    
    final stripsPerCarton = widget.stockItem.boxesPerCarton * widget.stockItem.stripsPerBox;
    final cartons = totalStrips ~/ stripsPerCarton;
    final remainingAfterCartons = totalStrips % stripsPerCarton;
    final boxes = remainingAfterCartons ~/ widget.stockItem.stripsPerBox;
    final strips = remainingAfterCartons % widget.stockItem.stripsPerBox;
    
    setState(() {
      _totalStrips = totalStrips;
      if (_isDirectStripInput) {
        _cartonsController.text = cartons.toString();
        _boxesController.text = boxes.toString();
        _stripsController.text = strips.toString();
      }
    });
  }

  void _incrementQuantity(String type) {
    switch (type) {
      case 'cartons':
        final current = int.tryParse(_cartonsController.text) ?? 0;
        _cartonsController.text = (current + 1).toString();
        break;
      case 'boxes':
        final current = int.tryParse(_boxesController.text) ?? 0;
        _boxesController.text = (current + 1).toString();
        break;
      case 'strips':
        final current = int.tryParse(_stripsController.text) ?? 0;
        _stripsController.text = (current + 1).toString();
        break;
    }
    _updateTotalStrips();
  }

  void _decrementQuantity(String type) {
    switch (type) {
      case 'cartons':
        final current = int.tryParse(_cartonsController.text) ?? 0;
        if (current > 0) {
          _cartonsController.text = (current - 1).toString();
        }
        break;
      case 'boxes':
        final current = int.tryParse(_boxesController.text) ?? 0;
        if (current > 0) {
          _boxesController.text = (current - 1).toString();
        }
        break;
      case 'strips':
        final current = int.tryParse(_stripsController.text) ?? 0;
        if (current > 0) {
          _stripsController.text = (current - 1).toString();
        }
        break;
    }
    _updateTotalStrips();
  }

  String _getAvailableQuantityDisplay() {
    final totalStrips = widget.stockItem.currentQuantityStrips;
    final stripsPerBox = widget.stockItem.stripsPerBox;
    final boxesPerCarton = widget.stockItem.boxesPerCarton;
    
    final stripsPerCarton = boxesPerCarton * stripsPerBox;
    final cartons = totalStrips ~/ stripsPerCarton;
    final remainingAfterCartons = totalStrips % stripsPerCarton;
    final boxes = remainingAfterCartons ~/ stripsPerBox;
    final strips = remainingAfterCartons % stripsPerBox;
    
    final parts = <String>[];
    if (cartons > 0) parts.add('$cartons Carton${cartons > 1 ? 's' : ''}');
    if (boxes > 0) parts.add('$boxes Box${boxes > 1 ? 'es' : ''}');
    if (strips > 0) parts.add('$strips Strip${strips > 1 ? 's' : ''}');
    
    return parts.isEmpty ? '0 Strips' : parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _totalStrips > 0 && _totalStrips <= widget.stockItem.currentQuantityStrips;
    final totalValue = _totalStrips * widget.stockItem.pricePerStrip;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.stockItem.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Batch: ${widget.stockItem.batchNumber}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Available: ${_getAvailableQuantityDisplay()}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input method toggle
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('By Units'),
                          selected: !_isDirectStripInput,
                          onSelected: (selected) {
                            setState(() {
                              _isDirectStripInput = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('By Strips'),
                          selected: _isDirectStripInput,
                          onSelected: (selected) {
                            setState(() {
                              _isDirectStripInput = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  if (_isDirectStripInput) ...[
                    // Direct strip input
                    const Text(
                      'Total Strips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _totalStripsController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Enter number of strips',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixText: 'strips',
                      ),
                      onChanged: (value) {
                        _updateFromTotalStrips();
                      },
                    ),
                  ] else ...[
                    // Unit-based input
                    _buildQuantityInput(
                      'Cartons',
                      _cartonsController,
                      'cartons',
                      '${widget.stockItem.boxesPerCarton} boxes each',
                    ),
                    const SizedBox(height: 16),
                    _buildQuantityInput(
                      'Boxes',
                      _boxesController,
                      'boxes',
                      '${widget.stockItem.stripsPerBox} strips each',
                    ),
                    const SizedBox(height: 16),
                    _buildQuantityInput(
                      'Strips',
                      _stripsController,
                      'strips',
                      'individual units',
                    ),
                  ],
                  
                  const SizedBox(height: 20),
                  
                  // Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Strips:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _totalStrips.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isValid ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Value:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '₹${totalValue.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        if (!isValid && _totalStrips > 0) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Exceeds available stock by ${_totalStrips - widget.stockItem.currentQuantityStrips} strips',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isValid
                          ? () {
                              widget.onConfirm(_totalStrips);
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontWeight: FontWeight.w600),
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

  Widget _buildQuantityInput(
    String label,
    TextEditingController controller,
    String type,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () => _decrementQuantity(type),
              icon: const Icon(Icons.remove_circle_outline),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey[100],
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onChanged: (value) => _updateTotalStrips(),
              ),
            ),
            IconButton(
              onPressed: () => _incrementQuantity(type),
              icon: const Icon(Icons.add_circle_outline),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey[100],
              ),
            ),
          ],
        ),
      ],
    );
  }
}