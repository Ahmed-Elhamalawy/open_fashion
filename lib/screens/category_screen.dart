import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_fashion/components/custome-text.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/components/product_card.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/providers/fav_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:open_fashion/services/products.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String _currentCategory = 'electronics';

  @override
  void initState() {
    super.initState();
  }

  void _updateCategory(String category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<String>> categoriesList = ProductsApi().getCategories();
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
          FutureBuilder(
            future: categoriesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              snapshot.data![index] == _currentCategory
                                  ? Colors.white38
                                  : Colors.white12,
                            ),
                          ),
                          child: CustomeText(
                            text: (snapshot.data![index]),
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: () {
                            _updateCategory(snapshot.data![index]);
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),

          // Products grid
          Expanded(
            child: FutureBuilder(
              future: productsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
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
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
