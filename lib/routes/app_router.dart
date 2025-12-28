import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_fashion/components/custom_bottom_tab_bar.dart'; // Import your custom app bar
import 'package:open_fashion/screens/add_card.dart';
import 'package:open_fashion/screens/adress.dart';
import 'package:open_fashion/screens/cart.dart';
import 'package:open_fashion/screens/chechout.dart';
import 'package:open_fashion/screens/home.dart';
import 'route_names.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: Stack(
              children: [
                child,

                // Floating Bottom Bar
                const Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: CustomBottomTabBar(),
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (context, state) => const Home(),
          ),
        ],
      ),
      //  Routes without app bar

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
    ],
  );
}
