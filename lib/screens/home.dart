// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/custom_app_bar.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/components/no_products_widget.dart';
import 'package:open_fashion/components/product_card.dart';
import 'package:open_fashion/components/shimmer_grid.dart';
import 'package:open_fashion/core/colors.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/providers/products_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    final cartCount = ref.watch(cartProvider).length;
    return Scaffold(
      appBar: CustomAppBar(
        logo: 'assets/images/logo.png',
        icon: Ionicons.cart,
        searchController: _searchController,
        badgeCount: cartCount,
        onSearchChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),

                /// Cover Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/cover/cover3.png'),
                ),
                const Gap(15),

                Center(child: Header(title: 'Products')),
                Center(
                  child: Image.asset(
                    'assets/svgs/line.png',
                    width: 200,
                  ),
                ),
                const Gap(20),

                /// Products Grid with async handling
                productsAsync.when(
                  loading: () => const ShimmerGrid(),
                  error: (err, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        'Error: $err',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  data: (allProducts) {
                    // Filter products based on search query
                    final filteredProducts = _searchQuery.isEmpty
                        ? allProducts
                        : allProducts
                            .where((product) =>
                                product.title
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()) ||
                                product.description
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                            .toList();

                    return filteredProducts.isEmpty
                        ? const NoProductsWidget()
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.53,
                            ),
                            itemBuilder: (context, index) {
                              final item = filteredProducts[index];

                              return ProductCard(product: item);
                            },
                          );
                  },
                ),

                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
