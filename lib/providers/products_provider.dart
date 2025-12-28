// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_fashion/models/product.dart';

// All products
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

// Products by category
final productsByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, category) async {
  final response = await http
      .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

// Single product
final productByIdProvider =
    FutureProvider.family<Product, int>((ref, id) async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

  if (response.statusCode == 200) {
    return Product.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
});

// Categories list
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => e.toString()).toList();
  } else {
    throw Exception('Failed to load categories');
  }
});
