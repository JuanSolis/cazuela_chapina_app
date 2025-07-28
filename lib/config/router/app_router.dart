import 'package:cazuela_chapina_app/features/auth/auth.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    ///* Product Routes
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
  ],
);
