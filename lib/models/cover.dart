class Cover {
  final String image;
  final String name;

  Cover({required this.image, required this.name});

  static List<Cover> covers = [
    Cover(image: 'assets/cover/cover1.png', name: 'Black Friday Sale'),
    Cover(image: 'assets/cover/cover2.png', name: 'New Arrivals'),
    Cover(image: 'assets/cover/cover3.png', name: 'Summer Collection'),
  ];
}
