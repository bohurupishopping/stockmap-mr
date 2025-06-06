import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationItem {
  final String name;
  final IconData icon;
  final String? path;
  final bool isSpecial;

  const BottomNavigationItem({
    required this.name,
    required this.icon,
    this.path,
    this.isSpecial = false,
  });
}

class CustomBottomNavigation extends StatelessWidget {
  final String currentPath;
  final VoidCallback? onNewOrderPressed;

  const CustomBottomNavigation({
    super.key,
    required this.currentPath,
    this.onNewOrderPressed,
  });

  final List<BottomNavigationItem> _routes = const [
    BottomNavigationItem(
      name: 'Home',
      icon: Icons.home,
      path: '/dashboard',
    ),
    BottomNavigationItem(
      name: 'Orders',
      icon: Icons.description,
      path: '/orders',
    ),
    BottomNavigationItem(
      name: 'New',
      icon: Icons.add,
      isSpecial: true,
    ),
    BottomNavigationItem(
      name: 'Finance',
      icon: Icons.account_balance_wallet,
      path: '/finance',
    ),
    BottomNavigationItem(
      name: 'Profile',
      icon: Icons.person,
      path: '/profile',
    ),
  ];



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
                          child: _buildSpecialTab(route),
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

  Widget _buildRegularTab(BuildContext context, BottomNavigationItem route, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (route.path != null) {
          context.go(route.path!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isActive ? const Color(0xFFe0e7ff) : Colors.white,
                border: Border.all(
                  color: isActive ? const Color(0xFF818cf8) : const Color(0xFFf1f5f9),
                  width: 2,
                ),
              ),
              child: Icon(
                route.icon,
                size: 24,
                color: isActive ? const Color(0xFF6366f1) : const Color(0xFF94a3b8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              route.name,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? const Color(0xFF6366f1) : const Color(0xFF94a3b8),
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialTab(BottomNavigationItem route) {
    return GestureDetector(
      onTap: onNewOrderPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF6366f1),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
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