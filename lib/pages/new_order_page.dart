import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_order/new_order_bloc.dart';
import '../bloc/new_order/new_order_event.dart';
import '../bloc/new_order/new_order_state.dart';

import '../widgets/loading_overlay.dart';
import '../widgets/new_order/stock_selection_section.dart';
import '../widgets/new_order/cart_section.dart';
import '../widgets/new_order/customer_section.dart';
import '../widgets/new_order/order_review_section.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Auto-load MR stock when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewOrderBloc>().add(const NewOrderEvent.loadMrStock());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _tabController.animateTo(_currentStep);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _tabController.animateTo(_currentStep);
    }
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _tabController.animateTo(step);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewOrderBloc(),
      child: BlocConsumer<NewOrderBloc, NewOrderState>(
        listener: (context, state) {
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
          
          if (state.hasSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }

          if (state.isOrderCreated) {
            _showOrderSuccessDialog(context, state.createdOrderId!);
          }
        },
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.isLoadingStock || state.isCreatingOrder,
            child: Scaffold(
              backgroundColor: Colors.grey[50],
              body: SafeArea(
                child: Column(
                  children: [
                    _buildModernHeader(state),
                    _buildStepIndicator(),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentStep = index;
                          });
                          _tabController.animateTo(index);
                        },
                        children: [
                          StockSelectionSection(
                            availableStock: state.availableStock,
                            isLoading: state.isLoadingStock,
                            onAddToCart: (stockItem, quantity) {
                              context.read<NewOrderBloc>().add(
                                    NewOrderEvent.addItemToCart(
                                      stockItem: stockItem,
                                      quantityStrips: quantity,
                                    ),
                                  );
                            },
                            onRefresh: () {
                              context
                                  .read<NewOrderBloc>()
                                  .add(const NewOrderEvent.loadMrStock());
                            },
                          ),
                          CartSection(
                            cartItems: state.cartItems,
                            onRemoveItem: (productId, batchId) {
                              context.read<NewOrderBloc>().add(
                                    NewOrderEvent.removeItemFromCart(
                                      productId: productId,
                                      batchId: batchId,
                                    ),
                                  );
                            },
                            onUpdateQuantity: (productId, batchId, quantity) {
                              context.read<NewOrderBloc>().add(
                                    NewOrderEvent.updateCartItemQuantity(
                                      productId: productId,
                                      batchId: batchId,
                                      newQuantityStrips: quantity,
                                    ),
                                  );
                            },
                            onClearCart: () {
                              context
                                  .read<NewOrderBloc>()
                                  .add(const NewOrderEvent.clearCart());
                            },
                          ),
                          CustomerSection(
                            customerName: state.customerName,
                            notes: state.notes,
                            onCustomerNameChanged: (name) {
                              context.read<NewOrderBloc>().add(
                                    NewOrderEvent.updateCustomerName(
                                      customerName: name,
                                    ),
                                  );
                            },
                            onNotesChanged: (notes) {
                              context.read<NewOrderBloc>().add(
                                    NewOrderEvent.updateNotes(notes: notes),
                                  );
                            },
                          ),
                          OrderReviewSection(
                            customerName: state.customerName,
                            notes: state.notes,
                            cartItems: state.cartItems,
                            isCreatingOrder: state.isCreatingOrder,
                            onConfirmOrder: () {
                              context.read<NewOrderBloc>().add(
                                    const NewOrderEvent.validateAndCreateOrder(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildNavigationButtons(state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernHeader(NewOrderState state) {
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                // Back button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Icon and title
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create New Order',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Step ${_currentStep + 1} of 4',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Auto-refresh indicator
                if (state.isLoadingStock)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Step tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildStepTab(0, 'Stock', Icons.inventory_2_rounded),
                _buildStepTab(1, 'Cart', Icons.shopping_cart_rounded),
                _buildStepTab(2, 'Customer', Icons.person_rounded),
                _buildStepTab(3, 'Review', Icons.receipt_long_rounded),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStepTab(int index, String label, IconData icon) {
    final isActive = index == _currentStep;
    final isCompleted = index < _currentStep;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _goToStep(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isActive 
                ? Colors.white 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive 
                    ? const Color(0xFF6366f1)
                    : isCompleted
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive 
                      ? const Color(0xFF6366f1)
                      : isCompleted
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF6366f1)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                if (index < 3)
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFF10b981)
                          : isActive
                              ? const Color(0xFF6366f1)
                              : Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: isActive || isCompleted ? [
                        BoxShadow(
                          color: (isCompleted ? const Color(0xFF10b981) : const Color(0xFF6366f1))
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 14,
                          )
                        : Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isActive
                                    ? Colors.white
                                    : Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNavigationButtons(NewOrderState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Previous',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _currentStep < 3
                    ? _nextStep
                    : state.canCreateOrder
                        ? () {
                            context.read<NewOrderBloc>().add(
                                  const NewOrderEvent
                                      .validateAndCreateOrder(),
                                );
                          }
                        : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: const Color(0xFF6366f1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: const Color(0xFF6366f1).withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.isCreatingOrder && _currentStep == 3)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      Icon(
                        _currentStep < 3 
                            ? Icons.arrow_forward_ios_rounded
                            : Icons.check_circle_rounded,
                        size: 16,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      _currentStep < 3 ? 'Next' : 'Create Order',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF10b981),
                      Color(0xFF059669),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10b981).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Order Created Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1f2937),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your order has been created and is ready for processing.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            orderId,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1f2937),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context
                            .read<NewOrderBloc>()
                            .add(const NewOrderEvent.resetOrderState());
                        setState(() {
                          _currentStep = 0;
                        });
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        _tabController.animateTo(0);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        'Create Another',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: const Color(0xFF6366f1),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}