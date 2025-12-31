// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:provider/provider.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.read<FavoriteProvider>();
    final cartProvider = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade800, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(product.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade900, Colors.red.shade600],
              ),
            ),
            child: const Icon(
              Ionicons.trash_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
          onDismissed: (direction) {
            favoriteProvider.toggleFav(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} removed from favorites'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red.shade700,
              ),
            );
          },
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  product.image,
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),

              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(8),

                      // Description
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(12),

                      // Price and Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            '${product.price} EGP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade300,
                            ),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              // Add to Cart Button
                              IconButton.filled(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.green.shade700,
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(
                                  Ionicons.cart_outline,
                                  size: 20,
                                ),
                                onPressed: () {
                                  cartProvider.addCartItem(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${product.title} added to cart'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.green.shade700,
                                    ),
                                  );
                                },
                              ),

                              // Remove from Favorites Button
                              IconButton.filled(
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.red),
                                highlightColor: Colors.white12,
                                icon: const Icon(
                                  Ionicons.heart_dislike_outline,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {
                                  favoriteProvider.toggleFav(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${product.title} removed from favorites'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.red.shade700,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
