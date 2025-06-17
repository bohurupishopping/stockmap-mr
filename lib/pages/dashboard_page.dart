// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../models/user_profile.dart';
import '../widgets/custom_bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // The navigation items remain the same, providing the data for the grid.
  final List<NavItem> navItems = const [
    NavItem(
      title: 'Stock',
      description: 'Manage inventory',
      icon: Icons.inventory_2_outlined,
      route: '/stock',
      color: Color(0xFF818cf8),
      gradientColors: [Color(0xFF818cf8), Color(0xFF6366f1)],
    ),
    NavItem(
      title: 'Orders',
      description: 'View my orders',
      icon: Icons.receipt_long_outlined,
      route: '/orders',
      color: Color(0xFF2E7D32),
      gradientColors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
    ),
    NavItem(
      title: 'Doctors',
      description: 'Manage doctors',
      icon: Icons.people_outline,
      route: '/doctors',
      color: Color(0xFF34d399),
      gradientColors: [Color(0xFF34d399), Color(0xFF10b981)],
    ),
    NavItem(
      title: 'Activity',
      description: 'View activity',
      icon: Icons.history_outlined,
      route: '/activity',
      color: Color(0xFFEC4C4C),
      gradientColors: [Color(0xFFEC4C4C), Color(0xFFE33E3E)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // The BLoC builder logic remains unchanged, correctly handling different auth states.
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return const _LoadingWidget();
        } else if (state is AuthAuthenticated) {
          return PageWithBottomNav(
            currentPath: '/dashboard',
            onNewOrderPressed: () => context.go('/create'),
            child: _DashboardContent(user: state.user, navItems: navItems),
          );
        } else if (state is AuthUnauthenticated) {
          // Navigates away in the listener, so a shrink box is appropriate.
          return const SizedBox.shrink();
        } else if (state is AuthError) {
          return _ErrorWidget(message: state.message);
        } else if (state is AuthAccessDenied) {
          return _ErrorWidget(message: state.message);
        }
        return const _LoadingWidget();
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final UserProfile user;
  final List<NavItem> navItems;

  const _DashboardContent({required this.user, required this.navItems});

  @override
  Widget build(BuildContext context) {
    // A slightly off-white background is easier on the eyes than pure white.
    return Container(
      color: const Color(0xFFF8F9FA),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, user.name),
              const SizedBox(height: 24),
              _buildContent(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top header section with a gradient and welcome message.
  Widget _buildHeader(BuildContext context, String userName) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366f1), Color(0xFF4f46e5)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Top bar with a modern, circular logout button.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.white.withOpacity(0.15),
                  shape: const CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () =>
                        context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      // A more modern logout icon.
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Welcome text content.
          Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the main content area containing the navigation grid.
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 20),
          _buildNavGrid(context),
        ],
      ),
    );
  }

  /// Builds the responsive grid of navigation items.
  Widget _buildNavGrid(BuildContext context) {
    return Wrap(
      spacing: 16, // Horizontal space between cards
      runSpacing: 16, // Vertical space between cards
      children: navItems.map((item) => _buildNavItem(context, item)).toList(),
    );
  }

  /// Builds a single, tappable navigation item card.
  Widget _buildNavItem(BuildContext context, NavItem item) {
    // Calculate width for two items per row with padding and spacing.
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 40 - 16) / 2; // (width - H_padding*2 - spacing) / 2

    return SizedBox(
      width: itemWidth,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // Navigation logic remains unchanged.
            if (['/stock', '/report', '/create', '/orders', '/doctors', '/activity'].contains(item.route)) {
              context.go(item.route);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} feature coming soon!'),
                  backgroundColor: item.color,
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
            ),
            child: Column(
              // Content is now centered horizontally.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(item.icon, size: 28, color: item.color),
                ),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: item.gradientColors[1],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748b),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data model for a navigation item.
class NavItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final Color color;
  final List<Color> gradientColors;

  const NavItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.color,
    required this.gradientColors,
  });
}

// A simple loading widget.
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// A reusable error display widget.
class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'An Error Occurred',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SelectableText(
                message,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}