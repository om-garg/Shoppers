class Product {
  final String productId;
  final String title;
  final String category;
  final String imgUrl;
  final String id;
  final String description;
  final int price;

  Product({
    required this.id,
    required this.category,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.productId,
    required this.title
  });
}