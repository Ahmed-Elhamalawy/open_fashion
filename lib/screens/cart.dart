// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/custome-text.dart';
import 'package:open_fashion/components/footer_btn.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ... imports ...

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the optimized providers
    final uniqueItems = ref.watch(groupedCartProvider);
    final totalPrice =
        ref.watch(cartTotalProvider); // Use the provider we made!
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Ionicons.chevron_back_circle,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.go(RouteNames.home); // Navigate back();
          },
        ),
        title: CustomeText(
          text: 'Cart',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: uniqueItems.isEmpty
          ? SafeArea(
              child: const Center(
                child: CustomeText(
                  text: 'Your cart is empty',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: uniqueItems.length,
                      itemBuilder: (context, index) {
                        final itemData = uniqueItems[index];
                        // Use 'product' as defined in your new groupedCartProvider
                        final item = itemData['product'];
                        final count = itemData['count'] as int;

                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(20),
                                // FIXED: Added null check for image URL
                                item.image != null && item.image.isNotEmpty
                                    ? Image.network(
                                        item.image,
                                        width: 100,
                                        height: 134,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, _, __) =>
                                            const Icon(Icons.broken_image,
                                                size: 100),
                                      )
                                    : const SizedBox(
                                        width: 100,
                                        height: 134,
                                        child: Icon(Icons.image_not_supported)),
                                const Gap(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomeText(
                                        text: item.title ??
                                            'No Title', // Null fallback
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      const Gap(6),
                                      CustomeText(
                                        text: item.description ??
                                            '', // Null fallback
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      const Gap(12),
                                      Row(
                                        children: [
                                          _QuantityBtn(
                                            icon: Icons.remove,
                                            onTap: () => cartNotifier
                                                .removeCartItem(item),
                                          ),
                                          const SizedBox(width: 13),
                                          CustomeText(
                                            text: count.toString(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 13),
                                          _QuantityBtn(
                                            icon: Icons.add,
                                            onTap: () =>
                                                cartNotifier.addCartItem(item),
                                          ),
                                        ],
                                      ),
                                      const Gap(12),
                                      CustomeText(
                                        text:
                                            '\$ ${(count * item.price).toStringAsFixed(2)}',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Use the new method we added to the provider!
                                    cartNotifier.removeAllOfProduct(item.id);
                                  },
                                )
                              ],
                            ),
                            const Gap(17),
                            Divider(
                                color: Colors.grey.shade400,
                                indent: 20,
                                endIndent: 20),
                            const Gap(17),
                          ],
                        );
                      },
                    ),
                  ),
                  // Footer section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomeText(
                            text: 'Est. Total',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        CustomeText(
                          text: '\$ ${totalPrice.toStringAsFixed(2)}',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  GestureDetector(
                    onTap: () => context.push(RouteNames.checkout,
                        extra: {'totalPrice': totalPrice}),
                    child: const FooterBtn(
                      text: 'Checkout',
                      icon: Ionicons.bag_handle_outline,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// Helper widget to keep code clean
class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuantityBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(196, 196, 196, 1)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, size: 20, color: const Color.fromRGBO(85, 85, 85, 1)),
      ),
    );
  }
}
