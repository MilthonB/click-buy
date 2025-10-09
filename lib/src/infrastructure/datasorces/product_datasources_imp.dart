import 'package:clickbuy/src/config/api/dio.dart';
import 'package:clickbuy/src/config/helper/error_to_message.dart';
import 'package:clickbuy/src/domain/datasources/products_datasources.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/infrastructure/mappers/products_mapper.dart';
import 'package:clickbuy/src/infrastructure/models/products_model.dart';
import 'package:dio/dio.dart';

class ProductDatasourcesImp implements ProductsDatasources {
  final DioClient _client = DioClient();

  @override
  Future<List<ProductEntity>> producsByCategoryName({
    String categoryName = '',
  }) async {
    try {
      final response = await _client.dio.get(
        '/products/category/$categoryName',
        queryParameters: {
          "limit": 20,
          "select":
              "id,title,description,price,discountPercentage,rating,stock,tags,sku,thumbnail",
        },
      );

      final productsJson = response.data['products'] as List<dynamic>;
      return mapJsonToProductEntity(productsJson);
    } on DioException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    } catch (e) {
      // throw ErrorToMessage.mapErrorMessage(e);
      throw "Ocurrió un error interno. Intenta nuevamente más tarde o contacta al soporte.";
    }
  }

  @override
  Future<List<ProductEntity>> products({int limit = 10, int skip = 10}) async {
    try {
      final response = await _client.dio.get(
        '/products',
        queryParameters: {
          "limit": 20,
          "skip": skip,
          "select":
              "id,title,description,price,discountPercentage,rating,stock,tags,sku,thumbnail",
        },
      );

      final productsJson = response.data['products'] as List<dynamic>;
      return mapJsonToProductEntity(productsJson);
    } on DioException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    } catch (e) {
      throw "Ocurrió un error interno. Intenta nuevamente más tarde o contacta al soporte.";
    }
  }

  @override
  Future<List<ProductEntity>> productsCarrusel({
    String email = '',
    String password = '',
  }) async {
    try {
      final response = await _client.dio.get(
        '/products',
        queryParameters: {
          "limit": 10,
          "select":
              "id,title,description,price,discountPercentage,rating,stock,tags,sku,thumbnail",
        },
      );

      final productsJson = response.data['products'] as List<dynamic>;
      return mapJsonToProductEntity(productsJson);
    } on DioException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    } catch (e) {
      throw "Ocurrió un error interno. Intenta nuevamente más tarde o contacta al soporte.";
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts({String nameProduct = ''}) async {
    try {
      final response = await _client.dio.get(
        '/products/search',
        queryParameters: {
          'q': nameProduct,
          "limit": 10,
          "select":
              "id,title,description,price,discountPercentage,rating,stock,tags,sku,thumbnail",
        },
      );

      final productsJson = response.data['products'] as List<dynamic>;
      return mapJsonToProductEntity(productsJson);
    } on DioException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    } catch (e) {
      throw "Ocurrió un error interno. Intenta nuevamente más tarde o contacta al soporte.";
    }
  }

  @override
  Future<ProductEntity> productById({int idProduct = 1}) async {
    try {
      final response = await _client.dio.get(
        '/products/$idProduct',
        queryParameters: {
          "select":
              "id,title,description,price,discountPercentage,rating,stock,tags,sku,thumbnail",
        },
      );

      final productsJson = response.data;
      return mapJsonToProductEntity(productsJson);
    } on DioException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    } catch (e) {
      throw "Ocurrió un error interno. Intenta nuevamente más tarde o contacta al soporte.";
    }
  }

  dynamic mapJsonToProductEntity(dynamic productsJson) {
    if (productsJson is List) {
      final model = productsJson
          .map((json) => ProductsModel.json(json))
          .toList();

      final entity = model
          .map((model) => ProductsMapper.productModuleToEntity(model))
          .toList();

      return entity;
    }

    final model = ProductsModel.json(productsJson);
    final entity = ProductsMapper.productModuleToEntity(model);

    return entity;
  }
}
