// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/widgets/custom_app_bar.dart';
import 'package:open_fashion/widgets/header.dart';
import 'package:open_fashion/widgets/no_products_widget.dart';
import 'package:open_fashion/widgets/product_card.dart';
import 'package:open_fashion/widgets/product_card_skeleton.dart';
import 'package:open_fashion/constants/colors.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:open_fashion/services/product_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final ProductsApi _api = ProductsApi();
  final user = FirebaseAuth.instance.currentUser;
  late final email = user?.email;

  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final result = await _api.getAllProducts();
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _products = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter products based on search query
    final filteredProducts = _searchQuery.isEmpty
        ? _products
        : _products
            .where(
              (product) =>
                  product.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ||
                  product.description
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()),
            )
            .toList();

    final count = context.watch<CartProvider>().items.length;

    return Scaffold(
      appBar: CustomAppBar(
        logo: 'assets/images/logo.png',
        icon: Ionicons.cart,
        searchController: _searchController,
        badgeCount: count,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Gap(20),
              const Center(child: Header(title: 'Explore All Products')),
              Center(
                child: Image.asset(
                  'assets/images/line.png',
                  width: 200,
                ),
              ),
              const Gap(20),

              /// Products Grid
              if (_isLoading)
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return const ProductCardSkeleton();
                  },
                )
              else if (_error != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      'Error: $_error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              else if (filteredProducts.isEmpty)
                const NoProductsWidget()
              else
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        context.goNamed(
                          RouteNames.productDetails,
                          pathParameters: {'id': product.id.toString()},
                        );
                      },
                      child: ProductCard(
                        isFav: context.watch<FavoriteProvider>().isFav(product),
                        product: product,
                        onFavoritePressed: () {
                          context.read<FavoriteProvider>().toggleFav(product);
                        },
                        onCartPressed: () {
                          context.read<CartProvider>().addCartItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.green.shade700,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              Gap(40)
            ]),
          ),
        ),
      ),
    );
  }
}
