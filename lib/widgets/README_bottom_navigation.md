# Custom Bottom Navigation Integration Guide

## Overview
The `CustomBottomNavigation` widget provides a modern, animated bottom navigation bar that can be easily integrated into any page in the app.

## Features
- ✨ Modern design with smooth animations
- 🎯 Special center button for primary actions (New Order)
- 🎨 Active state indicators with custom colors
- 📱 Responsive design that works on all screen sizes
- 🔧 Customizable navigation items
- 🚀 Easy integration with existing pages

## Quick Integration

### Method 1: Using PageWithBottomNav Wrapper (Recommended)

```dart
import '../widgets/custom_bottom_navigation.dart';

class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithBottomNav(
      currentPath: '/your-route', // Current route path
      onNewOrderPressed: () => context.go('/create'),
      child: YourPageContent(), // Your existing page content
    );
  }
}
```

### Method 2: Direct Integration

```dart
import '../widgets/custom_bottom_navigation.dart';

class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YourPageContent(),
      bottomNavigationBar: CustomBottomNavigation(
        currentPath: '/your-route',
        onNewOrderPressed: () => context.go('/create'),
      ),
    );
  }
}
```

## Customization

### Custom Navigation Items

```dart
final customNavItems = [
  BottomNavigationItem(
    name: 'Home',
    icon: Icons.home,
    path: '/dashboard',
  ),
  BottomNavigationItem(
    name: 'Custom',
    icon: Icons.star,
    onTap: () => showDialog(...), // Custom action
  ),
  BottomNavigationItem(
    name: 'Create',
    icon: Icons.add,
    isSpecial: true, // Makes it the center special button
  ),
];

PageWithBottomNav(
  currentPath: '/current',
  customNavItems: customNavItems,
  child: YourContent(),
)
```

## Default Navigation Items

The bottom navigation includes these default items:
- **Home** (`/dashboard`) - Dashboard/Home page
- **Orders** (`/orders`) - Orders listing
- **Create** (Special button) - Triggers create/new order action
- **Stock** (`/stock`) - Stock/Inventory page
- **Reports** (`/reports`) - Reports and analytics

## Integration Examples

### Dashboard Page
```dart
// Already integrated in dashboard_page.dart
return PageWithBottomNav(
  currentPath: '/dashboard',
  onNewOrderPressed: () => context.go('/create'),
  child: _DashboardContent(user: state.user, navItems: navItems),
);
```

### Orders Page
```dart
// Already integrated in orders_page.dart
return PageWithBottomNav(
  currentPath: '/orders',
  onNewOrderPressed: () => context.go('/create'),
  child: Container(
    color: const Color(0xFFF8FAFC),
    child: SafeArea(
      child: YourOrdersContent(),
    ),
  ),
);
```

## Important Notes

1. **Remove Existing Scaffold**: When using `PageWithBottomNav`, remove the `Scaffold` from your page content since the wrapper provides it.

2. **Route Paths**: Ensure the `currentPath` matches your actual route path for proper active state highlighting.

3. **SafeArea**: The wrapper handles SafeArea for the bottom navigation, but you may still need it for your content.

4. **Spacing**: Reduce bottom padding/spacing in your content since the bottom navigation is now handled by the wrapper.

## Styling

The bottom navigation uses a consistent color scheme:
- **Active Color**: `#6366f1` (Indigo)
- **Inactive Color**: `#94a3b8` (Slate)
- **Background**: White with subtle shadow
- **Special Button**: Circular with gradient shadow

## Animation

The navigation includes smooth transitions:
- 200ms duration for state changes
- Animated container transformations
- Smooth color transitions

## Accessibility

The component includes:
- Proper touch targets (minimum 44px)
- Semantic labels for screen readers
- High contrast colors for visibility

## Troubleshooting

### Common Issues

1. **Double Scaffold Error**: Remove `Scaffold` from your page content when using `PageWithBottomNav`.

2. **Navigation Not Highlighting**: Ensure `currentPath` exactly matches your route path.

3. **Content Overlap**: Add appropriate bottom padding to your scrollable content.

### Example Fix for Existing Pages

```dart
// Before
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyContent(),
    );
  }
}

// After
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithBottomNav(
      currentPath: '/my-route',
      onNewOrderPressed: () => context.go('/create'),
      child: MyContent(), // Remove Scaffold from MyContent
    );
  }
}
```