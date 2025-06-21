// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../models/order_models.dart';
import '../services/order_service.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/order_details_modal.dart';
import '../widgets/custom_bottom_navigation.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '₹', decimalDigits: 2);
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final DateFormat _timeFormat = DateFormat('hh:mm a');
  
  bool _isSearchFilterVisible = false;
  bool _isLoading = true;
  String _error = '';
  
  List<MrSalesOrder> _allOrders = [];
  List<MrSalesOrder> _filteredOrders = [];
  String _searchQuery = '';
  String _sortField = 'order_date';
  String _sortDirection = 'desc';
  String _statusFilter = 'all'; // all, pending, paid, partial
  
  // Summary data
  int _totalOrders = 0;
  int _pendingOrders = 0;
  int _paidOrders = 0;
  double _totalOrderValue = 0.0;
  
  @override
  void initState() {
    super.initState();
    _loadOrdersData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadOrdersData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final orders = await OrderService.getMrOrders();
      
      setState(() {
        _allOrders = orders;
        _filteredOrders = orders;
        _calculateSummary();
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load orders: $e';
        _isLoading = false;
      });
    }
  }

  void _calculateSummary() {
    _totalOrders = _allOrders.length;
    _pendingOrders = 0;
    _paidOrders = 0;
    _totalOrderValue = 0.0;
    
    for (final order in _allOrders) {
      switch (order.paymentStatus) {
        case PaymentStatus.pending:
          _pendingOrders++;
          break;
        case PaymentStatus.paid:
          _paidOrders++;
          break;
        case PaymentStatus.partial:
          // Count partial as pending for summary
          _pendingOrders++;
          break;
      }
      
      _totalOrderValue += order.totalAmount;
    }
  }

  void _applyFilters() {
    List<MrSalesOrder> filtered = List.from(_allOrders);
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               order.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               (order.notes?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }
    
    // Apply status filter
    if (_statusFilter != 'all') {
      PaymentStatus? targetStatus;
      switch (_statusFilter) {
        case 'pending':
          targetStatus = PaymentStatus.pending;
          break;
        case 'paid':
          targetStatus = PaymentStatus.paid;
          break;
        case 'partial':
          targetStatus = PaymentStatus.partial;
          break;
      }
      if (targetStatus != null) {
        filtered = filtered.where((order) => order.paymentStatus == targetStatus).toList();
      }
    }
    
    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      switch (_sortField) {
        case 'order_date':
          comparison = a.orderDate.compareTo(b.orderDate);
          break;
        case 'customer_name':
          comparison = a.customerName.compareTo(b.customerName);
          break;
        case 'total_amount':
          comparison = a.totalAmount.compareTo(b.totalAmount);
          break;
        case 'payment_status':
          comparison = a.paymentStatus.name.compareTo(b.paymentStatus.name);
          break;
      }
      return _sortDirection == 'asc' ? comparison : -comparison;
    });
    
    setState(() {
      _filteredOrders = filtered;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _onSortChanged(String field, String direction) {
    setState(() {
      _sortField = field;
      _sortDirection = direction;
    });
    _applyFilters();
  }

  void _onStatusFilterChanged(String filter) {
    setState(() {
      _statusFilter = filter;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithBottomNav(
      currentPath: '/dashboard/orders',
      onNewOrderPressed: () => context.go('/dashboard/create'),
      child: Container(
        color: const Color(0xFFF8FAFC),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: _buildContent(),
                  ),
                ],
              ),
              if (_isLoading) const LoadingOverlay(
                isLoading: true,
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  // Icon and title
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF475569),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Orders',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Manage your order history',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action buttons
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF475569),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isSearchFilterVisible = !_isSearchFilterVisible;
                        });
                      },
                      icon: Icon(
                        _isSearchFilterVisible ? Icons.tune : Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF475569),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _loadOrdersData,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ),
                ],
              ),
            ),
            // Collapsible Search and Filter Section
            if (_isSearchFilterVisible)
              _buildFilters(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_error.isNotEmpty) {
      return _buildErrorState();
    }

    return RefreshIndicator(
      color: const Color(0xFF1E293B),
      onRefresh: _loadOrdersData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Summary Cards
                _buildSummaryCards(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Orders List
          _buildOrdersList(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Unable to Load Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              _error,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadOrdersData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatusCard(
              'Total',
              _totalOrders.toString(),
              Icons.inventory_2_rounded,
              const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusCard(
              'Pending',
              _pendingOrders.toString(),
              Icons.schedule_rounded,
              const Color(0xFFEA580C),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusCard(
              'Paid',
              _paidOrders.toString(),
              Icons.check_circle_rounded,
              const Color(0xFF059669),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusCard(
              'Value',
              _formatCompactCurrency(_totalOrderValue),
              Icons.account_balance_wallet_rounded,
              const Color(0xFF7C3AED),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCompactCurrency(double amount) {
    if (amount >= 1000000) {
      return '₹${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return '₹${amount.toStringAsFixed(0)}';
    }
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search orders...',
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B), size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        padding: const EdgeInsets.all(8),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', 'all', _statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('Pending', 'pending', _statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('Paid', 'paid', _statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('Partial', 'partial', _statusFilter),
                const SizedBox(width: 16),
                _buildSortChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String currentValue) {
    final isSelected = currentValue == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF64748B),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => _onStatusFilterChanged(value),
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF1E293B),
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      ),
      elevation: 0,
      pressElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildSortChip() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        final parts = value.split('_');
        _onSortChanged(parts[0], parts[1]);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'order_date_desc', child: Text('Date (Newest first)')),
        const PopupMenuItem(value: 'order_date_asc', child: Text('Date (Oldest first)')),
        const PopupMenuItem(value: 'customer_name_asc', child: Text('Customer (A-Z)')),
        const PopupMenuItem(value: 'customer_name_desc', child: Text('Customer (Z-A)')),
        const PopupMenuItem(value: 'total_amount_desc', child: Text('Amount (High to Low)')),
        const PopupMenuItem(value: 'total_amount_asc', child: Text('Amount (Low to High)')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.sort_rounded, size: 16, color: Color(0xFF64748B)),
            const SizedBox(width: 6),
            Text(
              _getSortLabel(),
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              _sortDirection == 'asc' ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: const Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }

  String _getSortLabel() {
    switch (_sortField) {
      case 'order_date':
        return 'Date';
      case 'customer_name':
        return 'Customer';
      case 'total_amount':
        return 'Amount';
      case 'payment_status':
        return 'Status';
      default:
        return 'Date';
    }
  }

  Widget _buildOrdersList() {
    if (_filteredOrders.isEmpty) {
      return SliverToBoxAdapter(
        child: _buildEmptyState(),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final order = _filteredOrders[index];
            return _buildOrderCard(order);
          },
          childCount: _filteredOrders.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                size: 32,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'No matching orders'
                  : 'No orders yet',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'Try adjusting your search or filters'
                  : 'Your orders will appear here',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(MrSalesOrder order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showOrderDetails(order),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Order #${order.id.substring(0, 8)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildPaymentStatusChip(order.paymentStatus),
                ],
              ),
              const SizedBox(height: 16),
              
              // Order details in grid
              Row(
                children: [
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.calendar_today_rounded,
                      'Date',
                      _dateFormat.format(order.orderDate),
                    ),
                  ),
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.access_time_rounded,
                      'Time',
                      _timeFormat.format(order.orderDate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.shopping_cart_rounded,
                      'Items',
                      '${order.items.length} item${order.items.length != 1 ? 's' : ''}',
                    ),
                  ),
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.currency_rupee_rounded,
                      'Total',
                      _currencyFormat.format(order.totalAmount),
                    ),
                  ),
                ],
              ),
              
              if (order.notes != null && order.notes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.sticky_note_2_rounded,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          order.notes!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );  
  }

  Widget _buildPaymentStatusChip(PaymentStatus status) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    switch (status) {
      case PaymentStatus.pending:
        backgroundColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFD97706);
        label = 'Pending';
        break;
      case PaymentStatus.paid:
        backgroundColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF059669);
        label = 'Paid';
        break;
      case PaymentStatus.partial:
        backgroundColor = const Color(0xFFDDD6FE);
        textColor = const Color(0xFF7C3AED);
        label = 'Partial';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  void _showOrderDetails(MrSalesOrder order) {
    OrderDetailsModal.show(
      context: context,
      order: order,
      currencyFormat: _currencyFormat,
      dateFormat: _dateFormat,
      timeFormat: _timeFormat,
    );
  }
}