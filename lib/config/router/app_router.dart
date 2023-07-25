import 'package:go_router/go_router.dart';
import 'package:teslo_app/features/auth/auth.dart';
import 'package:teslo_app/features/products/products.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (_, __) => const ProductsScreen(),
    ),
  ],
);
