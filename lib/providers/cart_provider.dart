import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_fashion/models/product.dart';

// ------------------- Main Provider -------------------
class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => [];

  void addCartItem(Product product) {
    state = [...state, product];
  }

  void clearCartItems() {
    state = [];
  }

  void removeCartItem(Product product) {
    final index = state.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      state = [...state]..removeAt(index);
    }
  }

  void removeAllOfProduct(int productId) {
    state = state.where((item) => item.id != productId).toList();
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<Product>>(
  () => CartNotifier(),
);

// ------------------- duplicates handler Provider -------------------

final groupedCartProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final cart = ref.watch(cartProvider);

  final Map<int, List<Product>> groupedMap = {};
  for (var item in cart) {
    groupedMap.putIfAbsent(item.id, () => []).add(item);
  }

  return groupedMap.entries.map((entry) {
    return {
      'product': entry.value.first,
      'count': entry.value.length,
    };
  }).toList();
});

// ------------------- total price Provider -------------------
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.price);
});
