// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../models/order_models.dart';

// --- UI Constants for easy theming and consistency ---
const _primaryColor = Color(0xFF4338CA); // A modern, deep indigo
const _successColor = Color(0xFF10B981); // A vibrant, clear green
const _backgroundColor = Color(0xFFF3F4F6); // A light, neutral gray
const _cardBackgroundColor = Colors.white;
const _primaryTextColor = Color(0xFF1F2937);
const _secondaryTextColor = Color(0xFF6B7280);
const _borderColor = Color(0xFFE5E7EB);

class CombinedProductCartSection extends StatefulWidget {
  final List<MrStockItem> availableStock;
  final List<CartItem> cartItems;
  final bool isLoading;
  final Function(MrStockItem, int) onAddToCart;
  final Function(String, String, int) onUpdateQuantity;
  final Function(String, String) onRemoveItem;
  final VoidCallback onClearCart;

  const CombinedProductCartSection({
    super.key,
    required this.availableStock,
    required this.cartItems,
    required this.isLoading,
    required this.onAddToCart,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
    required this.onClearCart,
  });

  @override
  State<CombinedProductCartSection> createState() => _CombinedProductCartSectionState();
}

class _CombinedProductCartSectionState extends State<CombinedProductCartSection> {
  String _searchQuery = '';
  bool _showCart = false;
  final TextEditingController _searchController = TextEditingController();

  List<MrStockItem> get filteredStock {
    if (_searchQuery.isEmpty) return widget.availableStock;
    return widget.availableStock
        .where((item) =>
            item.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.batchNumber.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  double get totalAmount {
    return widget.cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantityStrips * item.pricePerStrip),
    );
  }

  int get totalItemsInCart {
    return widget.cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantityStrips,
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showCart
                  ? _buildCartView()
                  : _buildProductView(),
            ),
          ),
          // A cleaner, bottom-anchored cart summary bar
          if (!_showCart && widget.cartItems.isNotEmpty)
            _buildBottomCartSummary(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: MediaQuery.of(context).padding.top + 12),
      decoration: const BoxDecoration(
        color: _cardBackgroundColor,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _showCart ? 'Shopping Cart' : 'Available Products',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _primaryTextColor,
                ),
              ),
              _buildToggle(),
            ],
          ),
          if (!_showCart) ...[
            const SizedBox(height: 12),
            _buildSearchBar(),
          ],
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
          _buildToggleButton(Icons.inventory_2_outlined, !_showCart, () {
            if (_showCart) setState(() => _showCart = false);
          }),
          _buildToggleButton(Icons.shopping_cart_outlined, _showCart, () {
            if (!_showCart) setState(() => _showCart = true);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleButton(IconData icon, bool isActive, VoidCallback onTap) {
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
            Icon(
              icon,
              color: isActive ? Colors.white : _secondaryTextColor,
              size: 18,
            ),
            if (isActive && icon == Icons.shopping_cart_outlined && widget.cartItems.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                '${widget.cartItems.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      style: const TextStyle(color: _primaryTextColor),
      decoration: InputDecoration(
        hintText: 'Search by name or batch...',
        hintStyle: const TextStyle(color: _secondaryTextColor),
        prefixIcon: const Icon(Icons.search, color: _secondaryTextColor, size: 20),
        suffixIcon: _searchQuery.isNotEmpty ? IconButton(
          icon: const Icon(Icons.close, color: _secondaryTextColor, size: 20),
          onPressed: () {
            setState(() {
              _searchQuery = '';
              _searchController.clear();
            });
            FocusScope.of(context).unfocus();
          },
        ) : null,
        filled: true,
        fillColor: _backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildProductView() {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator(color: _primaryColor));
    }
    if (filteredStock.isEmpty) {
      return _buildEmptyState(
        icon: _searchQuery.isNotEmpty ? Icons.search_off_rounded : Icons.inventory_2_outlined,
        title: _searchQuery.isNotEmpty ? 'No Results Found' : 'No Stock Available',
        message: _searchQuery.isNotEmpty
            ? 'No products match "$_searchQuery".'
            : 'Check back later for new stock.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredStock.length,
      itemBuilder: (context, index) {
        final stockItem = filteredStock[index];
        final cartItem = widget.cartItems.where((item) => item.productId == stockItem.productId && item.batchId == stockItem.batchId).firstOrNull;
        return _buildProductCard(stockItem, cartItem);
      },
    );
  }

  Widget _buildProductCard(MrStockItem stockItem, CartItem? cartItem) {
    final bool isInCart = cartItem != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isInCart ? _successColor.withOpacity(0.5) : _borderColor,
          width: isInCart ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medication_outlined, color: _primaryColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stockItem.productName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _primaryTextColor)),
                    Text('Batch: ${stockItem.batchNumber}', style: const TextStyle(fontSize: 13, color: _secondaryTextColor)),
                  ],
                ),
              ),
              if (isInCart)
                const Icon(Icons.check_circle, color: _successColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDetailChip('Stock: ${stockItem.currentQuantityStrips}', Icons.inventory_2_outlined),
              const SizedBox(width: 8),
              _buildDetailChip('₹${stockItem.pricePerStrip.toStringAsFixed(2)}', Icons.currency_rupee_rounded),
            ],
          ),
          const SizedBox(height: 16),
          _buildAddToCartSection(stockItem, cartItem),
        ],
      ),
    );
  }

  Widget _buildDetailChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: _secondaryTextColor, size: 14),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: _secondaryTextColor, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildAddToCartSection(MrStockItem stockItem, CartItem? cartItem) {
    if (cartItem != null) {
      // Item is in cart, show quantity controls and remove button
      return Row(
        children: [
          Expanded(
            child: _QuantitySelector(
              quantity: cartItem.quantityStrips,
              maxQuantity: stockItem.currentQuantityStrips,
              onChanged: (newQuantity) {
                widget.onUpdateQuantity(stockItem.productId, stockItem.batchId, newQuantity);
              },
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => widget.onRemoveItem(stockItem.productId, stockItem.batchId),
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            style: IconButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      );
    } else {
      // Item not in cart, show add button
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: stockItem.currentQuantityStrips > 0
              ? () => widget.onAddToCart(stockItem, 1) // Add with default quantity of 1
              : null,
          icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
          label: const Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _successColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: _secondaryTextColor.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }
  }

  Widget _buildCartView() {
    if (widget.cartItems.isEmpty) {
      return _buildEmptyState(
        icon: Icons.shopping_cart_checkout_rounded,
        title: 'Your Cart is Empty',
        message: 'Add products from the list to get started.',
        action: ElevatedButton.icon(
          onPressed: () => setState(() => _showCart = false),
          icon: const Icon(Icons.inventory_2_outlined, size: 18),
          label: const Text('Browse Products'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }

    return Column(
      children: [
        _buildCartSummaryHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) => _buildCartItemCard(widget.cartItems[index]),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCartSummaryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$totalItemsInCart items',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _primaryTextColor),
              ),
              Text(
                'Total: ₹${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: _successColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: widget.onClearCart,
            icon: const Icon(Icons.delete_sweep_outlined, size: 18),
            label: const Text('Clear All'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.productName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _primaryTextColor)),
                Text('Batch: ${cartItem.batchNumber}', style: const TextStyle(fontSize: 12, color: _secondaryTextColor)),
                const SizedBox(height: 8),
                Text(
                  '₹${(cartItem.pricePerStrip * cartItem.quantityStrips).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _successColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _QuantitySelector(
            quantity: cartItem.quantityStrips,
            maxQuantity: cartItem.availableStrips,
            onChanged: (newQuantity) {
              widget.onUpdateQuantity(cartItem.productId, cartItem.batchId, newQuantity);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCartSummary() {
    return GestureDetector(
      onTap: () => setState(() => _showCart = true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
        decoration: const BoxDecoration(
          color: _primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$totalItemsInCart items in cart',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Total: ₹${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Text('View Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState({required IconData icon, required String title, required String message, Widget? action}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: _secondaryTextColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryTextColor)),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: _secondaryTextColor)),
            if (action != null) ...[
              const SizedBox(height: 24),
              action,
            ],
          ],
        ),
      ),
    );
  }
}

// --- Reusable Quantity Selector Widget ---
class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const _QuantitySelector({
    required this.quantity,
    required this.maxQuantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
            icon: const Icon(Icons.remove, size: 16),
            color: _secondaryTextColor,
            disabledColor: _secondaryTextColor.withOpacity(0.4),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
          SizedBox(
            width: 40,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _primaryTextColor),
            ),
          ),
          IconButton(
            onPressed: quantity < maxQuantity ? () => onChanged(quantity + 1) : null,
            icon: const Icon(Icons.add, size: 16),
            color: _secondaryTextColor,
            disabledColor: _secondaryTextColor.withOpacity(0.4),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}