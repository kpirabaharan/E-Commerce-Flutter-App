class Category {
  final String id;
  final String name;
  final String storeId;
  final String billboardId;

  const Category({
    required this.id,
    required this.name,
    required this.storeId,
    required this.billboardId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      storeId: json['storeId'],
      billboardId: json['billboardId'],
    );
  }
}
