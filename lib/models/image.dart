class CustomImage {
  final String id;
  final String productId;
  final String url;
  final String key;

  CustomImage({
    required this.id,
    required this.productId,
    required this.url,
    required this.key,
  });

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      id: json['id'],
      productId: json['productId'],
      url: json['url'],
      key: json['key'],
    );
  }
}
