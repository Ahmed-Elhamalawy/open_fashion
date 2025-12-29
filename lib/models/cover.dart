class Cover {
  final String image;
  final String name;

  Cover({required this.image, required this.name});

  static List<Cover> covers = [
    Cover(image: 'assets/images/cover1.png', name: 'Black Friday Sale'),
    Cover(image: 'assets/images/cover2.png', name: 'New Arrivals'),
    Cover(image: 'assets/images/cover3.png', name: 'Summer Collection'),
  ];
}
