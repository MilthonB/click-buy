


import 'package:clickbuy/src/domain/datasources/cart_datasources.dart';
import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/cart_repositorie.dart';

class CartRepositorieImp implements CartRepositorie{
  final CartDatasources datasources;

  CartRepositorieImp(this.datasources);

  @override
  Future<void> addProduct({required userId, required ProductEntity product, int quantity = 1}) {
    return datasources.addProduct(userId: userId, product: product, quantity: quantity);
  }

  @override
  Future<void> clearCart({required String userId}) {
    return datasources.clearCart(userId: userId);
  }

  @override
  Future<List<CartEntity>> getCartItems({required String userId}) {
    return datasources.getCartItems(userId: userId);
  }

  @override
  Future<double> getTotal({required String userId}) {
    return datasources.getTotal(userId: userId);
  }

  @override
  Future<void> removeProduct({required String userId,required ProductEntity product}) {
    return datasources.removeProduct(product: product, userId: userId);
  }

  @override
  Future<void> updateQuantity({ required String userId, required ProductEntity product, required int quantity}) {
    return datasources.updateQuantity(product: product, quantity: quantity, userId: userId);
  }
  
  @override
  Future<int> getTotalItems({required String userId}) {
    return datasources.getTotalItems(userId: userId);
  }
}