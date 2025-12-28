// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../components/custome-text.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    ref.read(cartProvider.notifier).addCartItem(product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Ionicons.cart,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    ref.read(cartProvider.notifier).addCartItem(product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
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
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          CustomeText(
            text: product.title,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),
          CustomeText(
            text: product.description,
            fontSize: 14,
            color: Colors.grey.shade400,
            maxLines: 2,
          ),
          const Gap(5),
          CustomeText(
            text: '\$ ${product.price}',
            fontSize: 16,
            color: Colors.red.shade200,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
