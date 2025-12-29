import 'package:flutter/material.dart';
import 'package:open_fashion/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  // ---------- GETTERS ----------
  List<Product> get items => List.unmodifiable(_items);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  List<Map<String, dynamic>> get groupedItems {
    final Map<int, List<Product>> groupedMap = {};

    for (var item in _items) {
      groupedMap.putIfAbsent(item.id, () => []).add(item);
    }

    return groupedMap.entries.map((entry) {
      return {
        'product': entry.value.first,
        'count': entry.value.length,
      };
    }).toList();
  }

  // ---------- ACTIONS ----------
  void addCartItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeCartItem(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void removeAllOfProduct(int productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void clearCartItems() {
    _items.clear();
    notifyListeners();
  }
}
