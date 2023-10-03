class Billboard {
  final String id;
  final String storeId;
  final String label;
  final String imageUrl;

  const Billboard({
    required this.id,
    required this.storeId,
    required this.label,
    required this.imageUrl,
  });

  factory Billboard.fromJson(Map<String, dynamic> json) {
    return Billboard(
      id: json['id'],
      storeId: json['storeId'],
      label: json['label'],
      imageUrl: json['imageUrl'],
    );
  }
}
