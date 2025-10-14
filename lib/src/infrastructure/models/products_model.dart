


class ProductsModel {

  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String sku;
  final String imagen;


  ProductsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.sku,
    required this.imagen
  });


  factory ProductsModel.json(Map<String, dynamic> json) {
    final tags = List<String>.from(json['tags'] ?? []);
    
    return ProductsModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    stock: json['stock'],
    tags: tags,
    sku: json['sku'],
    imagen: json['thumbnail'],
  );
  } 



}



