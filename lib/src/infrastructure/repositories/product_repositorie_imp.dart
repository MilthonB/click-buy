



import 'package:clickbuy/src/domain/datasources/products_datasources.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/product_respositorie.dart';

class ProductRepositorieImp implements ProductRespositorie {


  final ProductsDatasources datasources;

  ProductRepositorieImp(this.datasources);


  @override
  Future<List<ProductEntity>> producsByCategoryName({String categoryName =''}) {
    return datasources.producsByCategoryName(categoryName: categoryName);
  }

  @override
  Future<List<ProductEntity>> products({int limit = 10, int skip = 10}) {
    return datasources.products(limit: limit, skip: skip);
  }

  @override
  Future<List<ProductEntity>> productsCarrusel() {
    return datasources.productsCarrusel();
  }

  @override
  Future<List<ProductEntity>> searchProducts({String nameProduct=''}) {
    return datasources.searchProducts(nameProduct: nameProduct);
  }
}