import 'dart:developer';

import 'package:cazuela_chapina_app/config/router/app_router_notifier.dart';
import 'package:cazuela_chapina_app/features/auth/auth.dart';
import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart'
    show AuthStatus;
import 'package:cazuela_chapina_app/features/combos/presentation/screens/combos_screen.dart';
import 'package:cazuela_chapina_app/features/combos/presentation/screens/comprar_combo_screen.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterProviderNotifier);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Auth Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthScreen(),
      ),

      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Dashboard Route
      GoRoute(
        path: '/combos',
        builder: (context, state) => const CombosScreen(),
      ),

      GoRoute(
        path: '/combos/:id', // /product/new
        builder:
            (context, state) =>
                ComprarComboScreen(comboId: state.params['id'] ?? 'no-id'),
      ),

      //* Dashboard Route
      GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
    ],
    redirect: (context, state) {
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.unknown) {
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') {
          return null;
        }
        return "/login";
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return "/";
        }
      }
      return null;
    },
  );
});
