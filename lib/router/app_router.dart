import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
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
      initialLocation: '/login',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoginRoute = state.matchedLocation == '/login';
        
        if (authState is AuthInitial) {
          return '/login';
        } else if (authState is AuthLoading) {
          return null; // Stay on current route while loading
        } else if (authState is AuthAuthenticated) {
          return isLoginRoute ? '/dashboard' : null;
        } else if (authState is AuthUnauthenticated) {
          return isLoginRoute ? null : '/login';
        } else if (authState is AuthError) {
          return isLoginRoute ? null : '/login';
        } else if (authState is AuthAccessDenied) {
          return '/login';
        }
        return '/login';
      },
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/stock',
          name: 'stock',
          builder: (context, state) => const StockPage(),
        ),
        GoRoute(
          path: '/create',
          name: 'create',
          builder: (context, state) => const NewOrderPage(),
        ),
        GoRoute(
          path: '/report',
          name: 'report',
          builder: (context, state) => const ReportPage(),
        ),
        GoRoute(
          path: '/orders',
          name: 'orders',
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: '/speedometer',
          name: 'speedometer',
          builder: (context, state) => const SpeedometerPage(),
        ),
        GoRoute(
          path: '/doctors',
          name: 'doctors',
          builder: (context, state) => const DoctorsListPage(),
        ),
        GoRoute(
          path: '/doctors/:doctorId',
          name: 'doctor_detail',
          builder: (context, state) {
            final doctorId = state.pathParameters['doctorId']!;
            return DoctorDetailPage(doctorId: doctorId);
          },
        ),
        GoRoute(
          path: '/activity',
          name: 'activity',
          builder: (context, state) => const ActivityPage(),
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