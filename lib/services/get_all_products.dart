// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_fashion/models/product.dart';

class GetAllProducts {
  Future<List<Product>> getAllProducts() async {
    final uri = Uri.parse('https://fakestoreapi.com/products');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
