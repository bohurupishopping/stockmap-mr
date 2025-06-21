import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationItem {
  final String name;
  final IconData icon;
  final String? path;
  final bool isSpecial;
  final VoidCallback? onTap;

  const BottomNavigationItem({
    required this.name,
    required this.icon,
    this.path,
    this.isSpecial = false,
    this.onTap,
  });
}

class CustomBottomNavigation extends StatelessWidget {
  final String currentPath;
  final VoidCallback? onNewOrderPressed;
  final List<BottomNavigationItem>? customItems;

  const CustomBottomNavigation({
    super.key,
    required this.currentPath,
    this.onNewOrderPressed,
    this.customItems,
  });

  List<BottomNavigationItem> get _defaultRoutes => [
        const BottomNavigationItem(
          name: 'Home',
          icon: Icons.home,
          path: '/dashboard',
        ),
        const BottomNavigationItem(
          name: 'Orders',
          icon: Icons.description,
          path: '/dashboard/orders',
        ),
        const BottomNavigationItem(
          name: 'Create',
          icon: Icons.add,
          isSpecial: true,
          path: '/dashboard/create',
        ),
        const BottomNavigationItem(
          name: 'Stock',
          icon: Icons.inventory,
          path: '/dashboard/stock',
        ),
        const BottomNavigationItem(
          name: 'Goals',
          icon: Icons.speed,
          path: '/dashboard/speedometer',
        ),
      ];

  List<BottomNavigationItem> get _routes => customItems ?? _defaultRoutes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFf1f5f9),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 8,
            right: 8,
          ),
          child: Row(
            children: _routes.map((route) {
              final isActive = currentPath == route.path;
              
              if (route.isSpecial) {
                return Expanded(
                  child: _buildSpecialTab(context, route),
                );
              }
              
              return Expanded(
                child: _buildRegularTab(context, route, isActive),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildRegularTab(
    BuildContext context,
    BottomNavigationItem route,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () {
        if (route.onTap != null) {
          route.onTap!();
        } else if (route.path != null) {
          context.go(route.path!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isActive ? const Color(0xFFe0e7ff) : Colors.white,
                border: Border.all(
                  color: isActive
                      ? const Color(0xFF818cf8)
                      : const Color(0xFFf1f5f9),
                  width: 2,
                ),
              ),
              child: Icon(
                route.icon,
                size: 24,
                color: isActive
                    ? const Color(0xFF6366f1)
                    : const Color(0xFF94a3b8),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                color: isActive
                    ? const Color(0xFF6366f1)
                    : const Color(0xFF94a3b8),
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.5,
              ),
              child: Text(route.name),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialTab(BuildContext context, BottomNavigationItem route) {
    return GestureDetector(
      onTap: () {
        if (route.onTap != null) {
          route.onTap!();
        } else if (onNewOrderPressed != null) {
          onNewOrderPressed!();
        } else {
          context.go('/dashboard/create');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF6366f1),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x266366f1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                route.icon,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget to wrap pages with bottom navigation
class PageWithBottomNav extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final VoidCallback? onNewOrderPressed;
  final List<BottomNavigationItem>? customNavItems;

  const PageWithBottomNav({
    super.key,
    required this.child,
    required this.currentPath,
    this.onNewOrderPressed,
    this.customNavItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavigation(
        currentPath: currentPath,
        onNewOrderPressed: onNewOrderPressed,
        customItems: customNavItems,
      ),
    );
  }
}