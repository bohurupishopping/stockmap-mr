import 'package:flutter/material.dart';
import '../../models/order_models.dart';
import 'quantity_input_dialog.dart';

class StockSelectionSection extends StatefulWidget {
  final List<MrStockItem> availableStock;
  final bool isLoading;
  final Function(MrStockItem, int) onAddToCart;
  final VoidCallback onRefresh;

  const StockSelectionSection({
    super.key,
    required this.availableStock,
    required this.isLoading,
    required this.onAddToCart,
    required this.onRefresh,
  });

  @override
  State<StockSelectionSection> createState() => _StockSelectionSectionState();
}

class _StockSelectionSectionState extends State<StockSelectionSection> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MrStockItem> get filteredStock {
    if (_searchQuery.isEmpty) {
      return widget.availableStock;
    }
    
    return widget.availableStock.where((item) {
      final query = _searchQuery.toLowerCase();
      return item.productName.toLowerCase().contains(query) ||
          item.batchNumber.toLowerCase().contains(query) ||
          (item.manufacturer?.toLowerCase().contains(query) ?? false) ||
          (item.genericName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Header with search
        Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6366f1),
                          Color(0xFF8b5cf6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366f1).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available Stock',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1f2937),
                          ),
                        ),
                        Text(
                          '${filteredStock.length} items available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: widget.onRefresh,
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Colors.grey[700],
                      ),
                      tooltip: 'Refresh Stock',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Modern search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products, batches, manufacturers...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF6366f1),
                        size: 20,
                      ),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.all(12),
                            child: IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1f2937),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Stock list with modern design
        Expanded(
          child: widget.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        ),
                        child: const Column(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF6366f1),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Loading Stock',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1f2937),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Fetching available products...',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : filteredStock.isEmpty
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.all(40),
                        padding: const EdgeInsets.all(32),
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
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: _searchQuery.isEmpty
                                    ? Colors.orange.withValues(alpha: 0.1)
                                    : Colors.blue.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _searchQuery.isEmpty
                                    ? Icons.inventory_2_rounded
                                    : Icons.search_off_rounded,
                                size: 48,
                                color: _searchQuery.isEmpty
                                    ? Colors.orange[600]
                                    : Colors.blue[600],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'No Stock Available'
                                  : 'No Products Found',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1f2937),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'Contact your supervisor to get stock allocated to your account'
                                  : 'Try adjusting your search terms or check the spelling',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (_searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                                icon: const Icon(Icons.clear_rounded),
                                label: const Text('Clear Search'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6366f1),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        widget.onRefresh();
                      },
                      color: const Color(0xFF6366f1),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredStock.length,
                        itemBuilder: (context, index) {
                          final stockItem = filteredStock[index];
                          return _StockItemCard(
                            stockItem: stockItem,
                            onAddToCart: widget.onAddToCart,
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

class _StockItemCard extends StatelessWidget {
  final MrStockItem stockItem;
  final Function(MrStockItem, int) onAddToCart;

  const _StockItemCard({
    required this.stockItem,
    required this.onAddToCart,
  });

  String _formatQuantityDisplay() {
    final totalStrips = stockItem.currentQuantityStrips;
    final stripsPerBox = stockItem.stripsPerBox;
    final boxesPerCarton = stockItem.boxesPerCarton;
    
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
    final daysUntilExpiry = stockItem.expiryDate.difference(now).inDays;
    
    if (daysUntilExpiry <= 30) {
      return const Color(0xFFef4444);
    } else if (daysUntilExpiry <= 90) {
      return const Color(0xFFf59e0b);
    } else {
      return const Color(0xFF10b981);
    }
  }

  String _getExpiryStatus() {
    final now = DateTime.now();
    final daysUntilExpiry = stockItem.expiryDate.difference(now).inDays;
    
    if (daysUntilExpiry <= 30) {
      return 'Expires Soon';
    } else if (daysUntilExpiry <= 90) {
      return 'Expires in ${(daysUntilExpiry / 30).round()} months';
    } else {
      return 'Fresh Stock';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient background
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.medication_rounded,
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
                              stockItem.productName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1f2937),
                                height: 1.2,
                              ),
                            ),
                            if (stockItem.genericName != null) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  stockItem.genericName!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6366f1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                            if (stockItem.manufacturer != null) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.business_rounded,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      stockItem.manufacturer!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Expiry status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getExpiryColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _getExpiryColor().withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 18,
                              color: _getExpiryColor(),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${stockItem.expiryDate.day}/${stockItem.expiryDate.month}/${stockItem.expiryDate.year}',
                              style: TextStyle(
                                fontSize: 11,
                                color: _getExpiryColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getExpiryStatus(),
                              style: TextStyle(
                                fontSize: 9,
                                color: _getExpiryColor(),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Batch and quantity info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFf8fafc),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.1),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.qr_code_rounded,
                                size: 20,
                                color: Color(0xFF10b981),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Batch Number',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    stockItem.batchNumber,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1f2937),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory_rounded,
                                        size: 16,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Available Stock',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatQuantityDisplay(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1f2937),
                                    ),
                                  ),
                                  Text(
                                    '${stockItem.currentQuantityStrips} strips total',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10b981).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 18,
                                        color: Color(0xFF10b981),
                                      ),
                                      Text(
                                        stockItem.pricePerStrip.toStringAsFixed(2),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF10b981),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'per strip',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showQuantityDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366f1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }

  void _showQuantityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => QuantityInputDialog(
        stockItem: stockItem,
        onConfirm: (quantity) {
          onAddToCart(stockItem, quantity);
        },
      ),
    );
  }
}