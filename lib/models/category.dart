class Category {
  final int id;
  final String name;
  final String state;

  Category({
    required this.id,
    required this.name,
    required this.state,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['category_id'].toString()),
      name: json['category_name'],
      state: json['category_state'] ?? 'Activo',
    );
  }
}
