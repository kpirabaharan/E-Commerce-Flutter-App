class Store {
  final String id;
  final String name;
  final int limit;
  final String color;
  final String homeBillboardId;

  Store({
    required this.id,
    required this.name,
    required this.limit,
    required this.color,
    required this.homeBillboardId,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      limit: json['limit'],
      color: json['color'],
      homeBillboardId: json['homeBillboardId'],
    );
  }
}
