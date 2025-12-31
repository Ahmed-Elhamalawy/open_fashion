import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_fashion/widgets/categories_skeleton.dart';
import 'package:open_fashion/widgets/custome-text.dart';
import 'package:open_fashion/widgets/header.dart';
import 'package:open_fashion/widgets/product_card.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:open_fashion/services/product_service.dart';
import 'package:open_fashion/widgets/product_card_skeleton.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> _categories = [];
  List<Product> _products = [];
  bool _isLoadingCategories = true;
  bool _isLoadingProducts = true;
  String? _error;
  String _currentCategory = 'electronics';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchProducts();
  }

  // Categories Api
  Future<List<String>> _fetchCategories() async {
    try {
      final categories = await ProductsApi().getCategories();
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoadingCategories = false;
        _categories = categories;
      });
      return categories;
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>> _fetchProducts() async {
    try {
      final products =
          await ProductsApi().getProductsByCategory(_currentCategory);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoadingProducts = false;
        _products = products;
      });
      return products;
    } catch (e) {
      return [];
    }
  }

  void _updateCategory(String category) {
    setState(() {
      _currentCategory = category;
      _isLoadingProducts = true;
    });
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Product>> productsList =
        ProductsApi().getProductsByCategory(_currentCategory);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Header(title: 'Categorized Products'),
      ),
      body: Column(
        children: [
          // Categories horizontal list
          SizedBox(
            height: 60,
            child: _isLoadingCategories
                ? const Center(child: CategoriesSkeleton())
                : ListView.builder(
                    itemCount: _categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              _categories[index] == _currentCategory
                                  ? Colors.white38
                                  : Colors.white12,
                            ),
                          ),
                          child: CustomeText(
                            text: (_categories[index]),
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: () {
                            _updateCategory(_categories[index]);
                          },
                        ),
                      );
                    },
                  ),
          ),

          // Products grid
          Expanded(
            child: _isLoadingProducts
                ? GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const ProductCardSkeleton();
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return GestureDetector(
                        onTap: () {
                          context.goNamed(
                            RouteNames.productDetails,
                            pathParameters: {'id': product.id.toString()},
                          );
                        },
                        child: ProductCard(
                          isFav:
                              context.watch<FavoriteProvider>().isFav(product),
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
          ),

          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
