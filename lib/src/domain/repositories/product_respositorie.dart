import 'package:clickbuy/src/domain/entities/product_entity.dart';

abstract class ProductRespositorie {
  
  Future<List<ProductEntity>> searchProducts({String nameProduct});
  Future<List<ProductEntity>> productsCarrusel();
  Future<List<ProductEntity>> producsByCategoryName({String categoryName});
  Future<List<ProductEntity>> products({int limit = 10 , int skip = 10});

}
