import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/custome-text.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/models/product.dart';
import 'package:open_fashion/providers/cart_provider.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:open_fashion/services/products.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    final Future<Product> product = ProductsApi().getProductById(int.parse(id));
    final cart = context.watch<CartProvider>().items;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            context.go(RouteNames.home);
          },
          child: Icon(
            Ionicons.chevron_back_circle,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Header(title: 'Product Details'),
      ),
      body: FutureBuilder(
        future: product,
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            child: Image.network(
                              snapshot.data!.image,
                              width: double.infinity,
                              height: 300,
                            ),
                          ),
                          Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomeText(
                                text: snapshot.data!.title.length > 25
                                    ? '${snapshot.data!.title.substring(0, 25)}...'
                                    : snapshot.data!.title,
                                fontSize: 18,
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomeText(
                                text: 'EGP ${snapshot.data!.price.toString()}',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Gap(10),
                          // CustomeText(
                          //     text: snapshot.data!.rating!.rate.toString()),
                          // ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   shrinkWrap: true,
                          //   itemCount: 3,
                          //   itemBuilder: (context, index) => Icon(
                          //     Icons.star,
                          //     color: Colors.yellow,
                          //   ),
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomeText(
                                text: 'Description',
                                fontSize: 18,
                                maxLines: 2,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(10),
                              CustomeText(
                                text: snapshot.data!.description,
                                fontSize: 18,
                                maxLines: 2,
                              )
                            ],
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomeText(
                                text: 'Category',
                                fontSize: 18,
                                maxLines: 2,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(10),
                              CustomeText(
                                text: snapshot.data!.category,
                                fontSize: 18,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ],
                      )),
                  Spacer(),
                  if (!cart.any((element) => element.id == snapshot.data!.id))
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Expanded(
                        // This makes the button take all available width
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity,
                                50), // Changed fixedSize to minimumSize
                          ),
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .addCartItem(snapshot.data!);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomeText(
                                text: 'Add to cart',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(10),
                              Icon(
                                Ionicons.cart_outline,
                                color: Colors.black,
                                size: 29,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (cart.any((element) => element.id == snapshot.data!.id))
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            icon: const Icon(Icons.remove),
                            onPressed: () => context
                                .read<CartProvider>()
                                .removeCartItem(snapshot.data!),
                          ),
                          const Gap(30),
                          CustomeText(
                            text:
                                '${cart.where((item) => item.id == snapshot.data!.id).length}',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const Gap(30),
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            icon: const Icon(Icons.add),
                            onPressed: () => context
                                .read<CartProvider>()
                                .addCartItem(snapshot.data!),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
