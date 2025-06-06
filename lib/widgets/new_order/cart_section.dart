import 'package:flutter/material.dart';
import '../../models/order_models.dart';
import 'quantity_input_dialog.dart';

class CartSection extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String, String) onRemoveItem;
  final Function(String, String, int) onUpdateQuantity;
  final VoidCallback onClearCart;

  const CartSection({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.onUpdateQuantity,
    required this.onClearCart,
  });

  double get totalAmount {
    return cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantityStrips * item.pricePerStrip),
    );
  }

  int get totalItems {
    return cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantityStrips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6366f1).withValues(alpha: 0.05),
                const Color(0xFF8b5cf6).withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Color(0xFF6366f1),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f2937),
                    ),
                  ),
                  const Spacer(),
                  if (cartItems.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          _showClearCartDialog(context);
                        },
                        icon: const Icon(Icons.clear_all_rounded, size: 18),
                        label: const Text('Clear All'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red[600],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (cartItems.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.inventory_2_rounded,
                                    color: Color(0xFF6366f1),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$totalItems',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6366f1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total Strips',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${cartItems.length} product${cartItems.length > 1 ? 's' : ''}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10b981).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.currency_rupee_rounded,
                                    color: Color(0xFF10b981),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    totalAmount.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF10b981),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total Value',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Cart Summary',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Cart items
        Expanded(
          child: cartItems.isEmpty
              ? Center(
                  child: Container(
                    margin: const EdgeInsets.all(40),
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: Color(0xFF6366f1),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1f2937),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Add products from the stock section to get started with your order',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lightbulb_outline_rounded,
                                size: 20,
                                color: Color(0xFF6366f1),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Browse available stock to begin',
                                style: TextStyle(
                                  color: const Color(0xFF6366f1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return _CartItemCard(
                      cartItem: cartItem,
                      onRemove: () => onRemoveItem(
                        cartItem.productId,
                        cartItem.batchId,
                      ),
                      onUpdateQuantity: (newQuantity) => onUpdateQuantity(
                        cartItem.productId,
                        cartItem.batchId,
                        newQuantity,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Clear Cart'),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClearCart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity;

  const _CartItemCard({
    required this.cartItem,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  String _formatQuantityDisplay() {
    final totalStrips = cartItem.quantityStrips;
    final stripsPerBox = cartItem.stripsPerBox;
    final boxesPerCarton = cartItem.boxesPerCarton;
    
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

  Color _getExpiryColor() {
    final now = DateTime.now();
    final daysUntilExpiry = cartItem.expiryDate.difference(now).inDays;
    
    if (daysUntilExpiry <= 30) {
      return Colors.red;
    } else if (daysUntilExpiry <= 90) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineTotal = cartItem.quantityStrips * cartItem.pricePerStrip;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Product header with gradient background
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366f1).withValues(alpha: 0.1),
                  const Color(0xFF8b5cf6).withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medical_services_rounded,
                    color: Color(0xFF6366f1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.productName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1f2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Batch: ${cartItem.batchNumber}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: onRemove,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                      size: 22,
                    ),
                    tooltip: 'Remove from cart',
                  ),
                ),
              ],
            ),
          ),
          
          // Content section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Expiry date info
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _getExpiryColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getExpiryColor().withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: _getExpiryColor(),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Exp: ${cartItem.expiryDate.day}/${cartItem.expiryDate.month}/${cartItem.expiryDate.year}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getExpiryColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Quantity and pricing details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10b981).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.inventory_2_rounded,
                              size: 16,
                              color: Color(0xFF10b981),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity: ${_formatQuantityDisplay()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1f2937),
                                  ),
                                ),
                                Text(
                                  'Total Strips: ${cartItem.quantityStrips}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${cartItem.pricePerStrip.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const Text(
                                'per strip',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey[300]!,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            'Line Total:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1f2937),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10b981).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '₹${lineTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10b981),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Edit quantity button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showEditQuantityDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366f1),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit_rounded, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Edit Quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditQuantityDialog(BuildContext context) {
    // Convert CartItem to MrStockItem for the dialog
    final stockItem = MrStockItem(
      productId: cartItem.productId,
      batchId: cartItem.batchId,
      productName: cartItem.productName,
      batchNumber: cartItem.batchNumber,
      expiryDate: cartItem.expiryDate,
      currentQuantityStrips: cartItem.availableStrips,
      pricePerStrip: cartItem.pricePerStrip,
      stripsPerBox: cartItem.stripsPerBox,
      boxesPerCarton: cartItem.boxesPerCarton,
    );
    
    showDialog(
      context: context,
      builder: (context) => QuantityInputDialog(
        stockItem: stockItem,
        onConfirm: (quantity) {
          onUpdateQuantity(quantity);
        },
      ),
    );
  }
}