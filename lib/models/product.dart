class Product {
  final int id;
  final String name;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['product_id'].toString()),
      name: json['product_name'],
      price: double.parse(json['product_price'].toString()),
      image: json['product_image'],
    );
  }
}
