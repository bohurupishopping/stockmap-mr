import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_models.dart';
import '../services/order_service.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/order_details_modal.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildContent(),
                  const SizedBox(height: 100), // Space for bottom navigation
                ],
              ),
            ),
            if (_isLoading) const LoadingOverlay(
              isLoading: true,
              child: SizedBox.shrink(),
            ),
          ],
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
            Color(0xFF6366f1),
            Color(0xFF8b5cf6),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  // Icon and title
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'My Orders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Track your order history',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search/Filter toggle button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isSearchFilterVisible = !_isSearchFilterVisible;
                        });
                      },
                      icon: Icon(
                        _isSearchFilterVisible ? Icons.filter_list_off : Icons.filter_list,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Refresh button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _loadOrdersData,
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 24,
                      ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Summary Cards
          _buildSummaryCards(),
          // Orders List
          _buildOrdersList(),
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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Error Loading Orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1e293b),
              ),
            ),
            const SizedBox(height: 8),
            SelectableText.rich(
              TextSpan(
                text: _error,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadOrdersData,
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
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatusCard(
              'Total Orders',
              _totalOrders.toString(),
              Icons.shopping_bag_outlined,
              const Color(0xFF6366f1),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatusCard(
              'Pending',
              _pendingOrders.toString(),
              Icons.pending_actions,
              const Color(0xFFf59e0b),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatusCard(
              'Paid',
              _paidOrders.toString(),
              Icons.check_circle_outline,
              const Color(0xFF10b981),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatusCard(
              'Total Value',
              _currencyFormat.format(_totalOrderValue),
              Icons.currency_rupee,
              const Color(0xFF8b5cf6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: title == 'Total Value' ? 14 : 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748b),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search orders by customer, order ID, or notes...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF64748b),
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color(0xFF64748b),
                          size: 20,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
          color: isSelected ? Colors.white : const Color(0xFF64748b),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => _onStatusFilterChanged(value),
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF6366f1),
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366f1) : const Color(0xFFE2E8F0),
      ),
    );
  }

  Widget _buildSortChip() {
    return PopupMenuButton<String>(
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort: ${_getSortLabel()}',
              style: const TextStyle(
                color: Color(0xFF64748b),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              _sortDirection == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: const Color(0xFF64748b),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      onSelected: (value) {
        final parts = value.split('_');
        _onSortChanged(parts[0], parts[1]);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'order_date_desc',
          child: Text('Date (Newest first)'),
        ),
        const PopupMenuItem(
          value: 'order_date_asc',
          child: Text('Date (Oldest first)'),
        ),
        const PopupMenuItem(
          value: 'customer_name_asc',
          child: Text('Customer (A-Z)'),
        ),
        const PopupMenuItem(
          value: 'customer_name_desc',
          child: Text('Customer (Z-A)'),
        ),
        const PopupMenuItem(
          value: 'total_amount_desc',
          child: Text('Amount (High to Low)'),
        ),
        const PopupMenuItem(
          value: 'total_amount_asc',
          child: Text('Amount (Low to High)'),
        ),
      ],
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
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        color: const Color(0xFF6366f1),
        onRefresh: _loadOrdersData,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: _filteredOrders.length,
          itemBuilder: (context, index) {
            final order = _filteredOrders[index];
            return _buildOrderCard(order);
          },
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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: Color(0xFF6366f1),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'No orders match your filters'
                  : 'No orders found',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1e293b),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'Try adjusting your search or filters'
                  : 'Your orders will appear here once you place them',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
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
                            fontSize: 12,
                            color: Color(0xFF64748b),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildPaymentStatusChip(order.paymentStatus),
                ],
              ),
              const SizedBox(height: 12),
              
              // Order details
              Row(
                children: [
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.calendar_today,
                      'Date',
                      _dateFormat.format(order.orderDate),
                    ),
                  ),
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.access_time,
                      'Time',
                      _timeFormat.format(order.orderDate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.shopping_cart,
                      'Items',
                      '${order.items.length} item${order.items.length != 1 ? 's' : ''}',
                    ),
                  ),
                  Expanded(
                    child: _buildOrderDetailItem(
                      Icons.currency_rupee,
                      'Total',
                      _currencyFormat.format(order.totalAmount),
                    ),
                  ),
                ],
              ),
              
              if (order.notes != null && order.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.note,
                        size: 14,
                        color: Color(0xFF64748b),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          order.notes!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748b),
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
        Icon(
          icon,
          size: 14,
          color: const Color(0xFF64748b),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentStatusChip(PaymentStatus status) {
    Color color;
    String label;
    
    switch (status) {
      case PaymentStatus.pending:
        color = Colors.orange;
        label = 'Pending';
        break;
      case PaymentStatus.paid:
        color = Colors.green;
        label = 'Paid';
        break;
      case PaymentStatus.partial:
        color = Colors.blue;
        label = 'Partial';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
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