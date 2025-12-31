import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_fashion/providers/refresh_navigation_provider.dart';
import 'package:open_fashion/screens/auth/signin.dart';
import 'package:open_fashion/screens/auth/signup.dart';
import 'package:open_fashion/widgets/custom_bottom_tab_bar.dart';
import 'package:open_fashion/screens/add_card.dart';
import 'package:open_fashion/screens/adress.dart';
import 'package:open_fashion/screens/cart.dart';
import 'package:open_fashion/screens/category_screen.dart';
import 'package:open_fashion/screens/chechout.dart';
import 'package:open_fashion/screens/favorite.dart';
import 'package:open_fashion/screens/home.dart';
import 'package:open_fashion/screens/product_details.dart';
import 'route_names.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.signup,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: _handleRedirect,
    routes: [
      ..._shellRoutes,
      ..._standaloneRoutes,
      ..._authRoutes,
    ],
  );

  // Cleaner redirect logic
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final isAuthRoute = _isAuthRoute(state.matchedLocation);

    if (user == null && !isAuthRoute) {
      return RouteNames.signin;
    }

    if (user != null && isAuthRoute) {
      return RouteNames.home;
    }

    return null;
  }

  static bool _isAuthRoute(String location) {
    return location == RouteNames.signup || location == RouteNames.signin;
  }

  // Routes with bottom navigation bar
  static final _shellRoutes = [
    ShellRoute(
      builder: (context, state, child) => _ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: RouteNames.category,
          builder: (context, state) => const Category(),
        ),
        GoRoute(
          path: RouteNames.favorite,
          builder: (context, state) => const Favorite(),
        ),
      ],
    ),
  ];

  // Routes without bottom navigation bar
  static final _standaloneRoutes = [
    GoRoute(
      path: RouteNames.cart,
      builder: (context, state) => const Cart(),
    ),
    GoRoute(
      path: RouteNames.checkout,
      builder: (context, state) => const Chechout(),
    ),
    GoRoute(
      path: RouteNames.adress,
      builder: (context, state) => const Adress(),
    ),
    GoRoute(
      path: RouteNames.addCard,
      builder: (context, state) => const AddCard(),
    ),
    GoRoute(
      name: RouteNames.productDetails,
      path: '/productDetails/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetails(id: id);
      },
    ),
  ];

  // Authentication routes
  static final _authRoutes = [
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: RouteNames.signin,
      builder: (context, state) => const SignIn(),
    ),
  ];
}

// Extract the shell scaffold for cleaner code
class _ShellScaffold extends StatelessWidget {
  final Widget child;

  const _ShellScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          const Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: CustomBottomTabBar(),
          ),
        ],
      ),
    );
  }
}
