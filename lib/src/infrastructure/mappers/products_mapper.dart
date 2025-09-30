


import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/infrastructure/models/products_model.dart';

class ProductsMapper {

  static ProductEntity productModuleToEntity(ProductsModel model) => ProductEntity(
    id: model.id, 
    title: model.title, 
    description: model.description, 
    price: model.price, 
    discountPercentage: model.discountPercentage, 
    rating: model.rating, 
    stock: model.stock, 
    tags: model.tags, 
    sku: model.sku,
    imagen: model.imagen
  );

}


