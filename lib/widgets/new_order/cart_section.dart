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
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (cartItems.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        _showClearCartDialog(context);
                      },
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text('Clear All'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
              if (cartItems.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$totalItems strips',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            '${cartItems.length} product${cartItems.length > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            'Total Value',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add products from the stock section to get started',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
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
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Batch: ${cartItem.batchNumber}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getExpiryColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _getExpiryColor().withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'Exp: ${cartItem.expiryDate.day}/${cartItem.expiryDate.month}/${cartItem.expiryDate.year}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getExpiryColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      tooltip: 'Remove from cart',
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatQuantityDisplay(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total strips:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${cartItem.quantityStrips} strips',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price per strip:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '₹${cartItem.pricePerStrip.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Line Total:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${lineTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showEditQuantityDialog(context);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Quantity'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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