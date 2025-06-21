import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/new_order/new_order_bloc.dart';
import '../bloc/new_order/new_order_event.dart';
import '../bloc/new_order/new_order_state.dart';

import '../widgets/loading_overlay.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/new_order/combined_product_cart_section.dart';
import '../widgets/new_order/combined_customer_review_section.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewOrderBloc()..add(const NewOrderEvent.loadMrStock()),
      child: BlocConsumer<NewOrderBloc, NewOrderState>(
        listener: (context, state) {
          // Notifications removed for cleaner UX

          if (state.isOrderCreated) {
            _showOrderSuccessDialog(context, state.createdOrderId!);
          }
        },
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.isLoadingStock || state.isCreatingOrder,
            child: PageWithBottomNav(
              currentPath: '/dashboard/create',
              onNewOrderPressed: () => context.go('/dashboard/create'),
              child: Container(
                color: Colors.grey[50],
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentStep = index;
                            });
                          },
                          children: [
                            CombinedProductCartSection(
                              availableStock: state.availableStock,
                              cartItems: state.cartItems,
                              isLoading: state.isLoadingStock,
                              onAddToCart: (stockItem, quantity) {
                                context.read<NewOrderBloc>().add(
                                  NewOrderEvent.addItemToCart(
                                    stockItem: stockItem,
                                    quantityStrips: quantity,
                                  ),
                                );
                              },
                              onUpdateQuantity: (productId, batchId, newQuantity) {
                                context.read<NewOrderBloc>().add(
                                  NewOrderEvent.updateCartItemQuantity(
                                    productId: productId,
                                    batchId: batchId,
                                    newQuantityStrips: newQuantity,
                                  ),
                                );
                              },
                              onRemoveItem: (productId, batchId) {
                                context.read<NewOrderBloc>().add(
                                  NewOrderEvent.removeItemFromCart(
                                    productId: productId,
                                    batchId: batchId,
                                  ),
                                );
                              },
                              onClearCart: () {
                                context.read<NewOrderBloc>().add(
                                  const NewOrderEvent.clearCart(),
                                );
                              },
                            ),
                            CombinedCustomerReviewSection(
                              customerName: state.customerName,
                              notes: state.notes,
                              cartItems: state.cartItems,
                              totalAmount: state.totalAmount,
                              stockValidationErrors: state.stockValidationErrors,
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
            ),
          );
        },
      ),
    );
  }



  Widget _buildNavigationButtons(NewOrderState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Previous',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _currentStep < 1
                    ? _nextStep
                    : state.canCreateOrder
                    ? () {
                        context.read<NewOrderBloc>().add(
                          const NewOrderEvent.validateAndCreateOrder(),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: _currentStep == 1
                      ? const Color(0xFF10b981)
                      : const Color(0xFF6366f1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.isCreatingOrder && _currentStep == 1)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    else
                      Icon(
                        _currentStep < 1
                            ? Icons.arrow_forward_ios_rounded
                            : Icons.check_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    const SizedBox(width: 6),
                    Text(
                      _currentStep < 1 ? 'Next' : 'Create Order',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          Spacer(),
        ],
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                    colors: [Color(0xFF10b981), Color(0xFF059669)],
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
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                        context.read<NewOrderBloc>().add(
                          const NewOrderEvent.resetOrderState(),
                        );
                        setState(() {
                          _currentStep = 0;
                        });
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );

                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
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
                        context.go('/dashboard');
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
                        'Home',
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
