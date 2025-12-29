// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../components/custome-text.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.read<CartProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.product.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Cart button
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    cartNotifier.addCartItem(widget.product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Ionicons.cart,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              // Favorite button
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    favoriteProvider
                        .toggleFav(widget.product); // Or your favorite logic
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Ionicons.heart,
                      size: 30,
                      color: context
                              .watch<FavoriteProvider>()
                              .isFav(widget.product)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),

          const Gap(10),

          // Product Title
          CustomeText(
            text: widget.product.title,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),

          // Product Description
          CustomeText(
            text: widget.product.description,
            fontSize: 14,
            color: Colors.grey.shade400,
            maxLines: 2,
          ),

          const Gap(5),

          // Product Price
          CustomeText(
            text: '\$ ${widget.product.price}',
            fontSize: 16,
            color: Colors.red.shade200,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
