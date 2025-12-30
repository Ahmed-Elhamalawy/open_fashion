import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/widgets/favorite_product_card.dart';
import 'package:open_fashion/widgets/header.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final Set<Product> favoriteSet = context.watch<FavoriteProvider>().favs;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Header(
          title: 'My Favorites',
        ),
      ),
      body: favoriteSet.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.heart_outline,
                    size: 100,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Favorites Yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start adding products to your favorites!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteSet.length,
              itemBuilder: (context, index) {
                final product = favoriteSet.elementAt(index);
                return GestureDetector(
                    onTap: () {
                      context.goNamed(
                        RouteNames.productDetails,
                        pathParameters: {'id': product.id.toString()},
                      );
                    },
                    child: FavoriteProductCard(product: product));
              },
            ),
    );
  }
}
