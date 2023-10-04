class Image {
  final String id;
  final String productId;
  final String url;
  final String key;

  Image({
    required this.id,
    required this.productId,
    required this.url,
    required this.key,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      productId: json['productId'],
      url: json['url'],
      key: json['key'],
    );
  }
}
