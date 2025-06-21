import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../pages/splash_screen.dart';
import '../pages/login_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/stock_page.dart';
import '../pages/report_page.dart';
import '../pages/new_order_page.dart';
import '../pages/orders_page.dart';
import '../pages/speedometer_page.dart';
import '../pages/doctors_list_page.dart';
import '../pages/doctor_detail_page.dart';
import '../pages/activity_page.dart';

class AppRouter {
  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final authState = authBloc.state;
        final isSplashRoute = state.matchedLocation == '/';
        final isLoginRoute = state.matchedLocation == '/login';
        
        // Always allow splash screen during initial load
        if (isSplashRoute && (authState is AuthInitial || authState is AuthLoading)) {
          return null;
        }
        
        // Handle authenticated state
        if (authState is AuthAuthenticated) {
          if (isSplashRoute || isLoginRoute) {
            return '/dashboard';
          }
          return null;
        }
        
        // Handle unauthenticated states
        if (authState is AuthUnauthenticated || 
            authState is AuthError || 
            authState is AuthAccessDenied) {
          if (!isLoginRoute) {
            return '/login';
          }
          return null;
        }
        
        // Default case
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
          routes: [
            GoRoute(
              path: 'stock',
              name: 'stock',
              builder: (context, state) => const StockPage(),
            ),
            GoRoute(
              path: 'create',
              name: 'create',
              builder: (context, state) => const NewOrderPage(),
            ),
            GoRoute(
              path: 'report',
              name: 'report',
              builder: (context, state) => const ReportPage(),
            ),
            GoRoute(
              path: 'orders',
              name: 'orders',
              builder: (context, state) => const OrdersPage(),
            ),
            GoRoute(
              path: 'speedometer',
              name: 'speedometer',
              builder: (context, state) => const SpeedometerPage(),
            ),
            GoRoute(
              path: 'doctors',
              name: 'doctors',
              builder: (context, state) => const DoctorsListPage(),
              routes: [
                GoRoute(
                  path: ':doctorId',
                  name: 'doctor_detail',
                  builder: (context, state) {
                    final doctorId = state.pathParameters['doctorId']!;
                    return DoctorDetailPage(doctorId: doctorId);
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'activity',
              name: 'activity',
              builder: (context, state) => const ActivityPage(),
            ),
          ],
        ),
      ],
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (AuthState state) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
