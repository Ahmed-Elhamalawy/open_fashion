class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  // final Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    // this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      // rating:
      // Rating(rate: json['rating']['rate'], count: json['rating']['count']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// class Rating {
//   final double rate;
//   final double count;

//   Rating({required this.rate, required this.count});
// }
