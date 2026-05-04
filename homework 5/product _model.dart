
class Product {
  final String id;
  final String name;
  final String brand;
  final String price;
  final String description;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toString(),
      description: json['description'],
      image: json['image'],
      category: json['category'],
    );
  }
}
