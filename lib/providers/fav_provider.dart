import 'package:flutter/material.dart';
import 'package:open_fashion/models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  Set<Product> favs = {};

  void toggleFav(Product product) {
    if (favs.contains(product)) {
      favs.remove(product);
    } else {
      favs.add(product);
    }
    notifyListeners();
  }

  bool isFav(Product product) {
    return favs.contains(product);
  }
}
