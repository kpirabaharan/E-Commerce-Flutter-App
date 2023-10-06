class Size {
  final String id;
  final String name;
  final String value;

  const Size({
    required this.id,
    required this.name,
    required this.value,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }
}
