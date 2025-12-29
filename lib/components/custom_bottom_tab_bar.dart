import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/tab_item.dart';
import 'package:open_fashion/routes/route_names.dart';

class CustomBottomTabBar extends StatelessWidget {
  const CustomBottomTabBar({super.key});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location == '/favorite') return 2;
    if (location == '/profile') return 3;
    if (location == '/grid') return 1;
    if (location == '/') return 0;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabItem(
            icon: Icons.home,
            active: currentIndex == 0,
            onTap: () => context.go(RouteNames.home),
          ),
          TabItem(
            icon: Ionicons.grid,
            active: currentIndex == 1,
            onTap: () {},
          ),
          TabItem(
            icon: Ionicons.heart,
            active: currentIndex == 2,
            onTap: () => context.go(RouteNames.favorite),
          ),
          TabItem(
            icon: Ionicons.person,
            active: currentIndex == 3,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
