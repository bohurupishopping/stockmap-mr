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
    
    // Load MR stock when page initializes
    context.read<NewOrderBloc>().add(const NewOrderEvent.loadMrStock());
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
              appBar: AppBar(
                title: const Text(
                  'Create New Order',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      onTap: _goToStep,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.inventory_2_outlined, size: 20),
                          text: 'Stock',
                        ),
                        Tab(
                          icon: Icon(Icons.shopping_cart_outlined, size: 20),
                          text: 'Cart',
                        ),
                        Tab(
                          icon: Icon(Icons.person_outline, size: 20),
                          text: 'Customer',
                        ),
                        Tab(
                          icon: Icon(Icons.receipt_long_outlined, size: 20),
                          text: 'Review',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  // Progress indicator
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: List.generate(4, (index) {
                        final isActive = index <= _currentStep;
                        final isCompleted = index < _currentStep;
                        
                        return Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              if (index < 3)
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: isCompleted
                                        ? Theme.of(context).primaryColor
                                        : isActive
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: isCompleted
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        )
                                      : Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              color: isActive
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                              fontSize: 10,
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
                  ),
                  
                  // Page content
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
                  
                  // Navigation buttons
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _previousStep,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Previous'),
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
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              _currentStep < 3 ? 'Next' : 'Create Order',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
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
        },
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Created Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: $orderId',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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
                    child: const Text('Create Another'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}