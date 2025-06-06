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
        // Search and header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2,
                    color: Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Available Stock',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: widget.onRefresh,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Refresh Stock',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products, batches, or manufacturers...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ],
          ),
        ),
        
        // Stock list
        Expanded(
          child: widget.isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading available stock...'),
                    ],
                  ),
                )
              : filteredStock.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchQuery.isEmpty
                                ? Icons.inventory_2_outlined
                                : Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No stock available'
                                : 'No products found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchQuery.isEmpty
                                ? 'Contact your supervisor to get stock allocated'
                                : 'Try adjusting your search terms',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_searchQuery.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              child: const Text('Clear Search'),
                            ),
                          ],
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        widget.onRefresh();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
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
      return Colors.red;
    } else if (daysUntilExpiry <= 90) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        stockItem.productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (stockItem.genericName != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          stockItem.genericName!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      if (stockItem.manufacturer != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'by ${stockItem.manufacturer}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
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
                    'Exp: ${stockItem.expiryDate.day}/${stockItem.expiryDate.month}/${stockItem.expiryDate.year}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _getExpiryColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Batch: ${stockItem.batchNumber}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Available: ${_formatQuantityDisplay()}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Total: ${stockItem.currentQuantityStrips} strips',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${stockItem.pricePerStrip.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const Text(
                        'per strip',
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
            
            const SizedBox(height: 12),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showQuantityDialog(context);
                },
                icon: const Icon(Icons.add_shopping_cart, size: 18),
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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