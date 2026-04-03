class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;        
  final double oldPrice;
  final bool hasDiscount;
  final String type;     
  final String categoryId;

  ProductModel({required this.id, required this.name, required this.imageUrl, required this.price, required this.oldPrice, required this.hasDiscount, required this.type, required this.categoryId}); 
}