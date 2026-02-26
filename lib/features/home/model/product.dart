class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final double? rating;
  final String? category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.rating,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      rating: (json['rating'] as Map<String, dynamic>?)?['rate'] != null
          ? ((json['rating'] as Map<String, dynamic>)['rate'] as num).toDouble()
          : null,
      category: json['category'] as String?,
    );
  }
}
