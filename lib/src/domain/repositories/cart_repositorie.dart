import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';

abstract class CartRepositorie {
  /// Obtiene la lista actual de items en el carrito
  Future<List<CartEntity>> getCartItems({required String userId});

  /// Agrega un producto al carrito
  Future<void> addProduct({required String userId, required ProductEntity product, int quantity = 1});

  /// Quita un producto del carrito
  Future<void> removeProduct({required String userId, required ProductEntity product});

  /// Actualiza la cantidad de un producto
  Future<void> updateQuantity({required String userId, required ProductEntity product, required int quantity});

  /// Vacía todo el carrito
  Future<void> clearCart({required String userId});

  /// Devuelve el total del carrito
  Future<double> getTotal({required String userId});

    Future<int> getTotalItems({required String userId});

}
