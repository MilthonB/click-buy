import 'dart:async';

import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/cart_repositorie.dart';
import 'package:clickbuy/src/infrastructure/datasorces/cart_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/cart_repositorie_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
CartRepositorie cartDatasources(ref) {
  return CartRepositorieImp(CartDatasourcesImp());
}

@riverpod
class Cart extends _$Cart {
  @override
  Future<List<CartEntity>> build() async {
    return [];
  }

  Future<void> loadCart(String userId) async {
    state = const AsyncLoading();
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      final items = await datasource.getCartItems(userId: userId);
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addToCart(
    String userId,
    ProductEntity product, {
    int quantity = 1,
  }) async {
    state = const AsyncLoading();
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      await datasource.addProduct(
        userId: userId,
        product: product,
        quantity: quantity,
      );

      unawaited(loadCart(userId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeFromCart(String userId, dynamic product) async {
    state = const AsyncLoading();
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      await datasource.removeProduct(userId: userId, product: product);
      await loadCart(userId);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateQuantity(
    String userId,
    dynamic product,
    int quantity,
  ) async {
    state = const AsyncLoading();
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      await datasource.updateQuantity(
        userId: userId,
        product: product,
        quantity: quantity,
      );
      await loadCart(userId);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> clearCart(String userId) async {
    state = const AsyncLoading();
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      await datasource.clearCart(userId: userId);
      state = const AsyncData([]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<double> getTotal(String userId) async {
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      return await datasource.getTotal(userId: userId);
    } catch (e) {
      return 0.0;
    }
  }

  Future<int> getTotalItems(String userId) async {
    try {
      final datasource = ref.read(cartDatasourcesProvider);
      return await datasource.getTotalItems(userId: userId);
    } catch (e) {
      return 0;
    }
  }
}

@riverpod
class CartTotals extends _$CartTotals {
  @override
  Map<String, double> build() {
    final cart = ref
        .watch(cartProvider)
        .maybeWhen(data: (items) => items, orElse: () => <CartEntity>[]);

    return _calculateTotals(cart);
  }

  Map<String, double> _calculateTotals(List<CartEntity> cart) {
    int items = 0;
    double total = 0;

    for (var c in cart) {
      items += c.quantity;
      total +=
          c.quantity *
          c.product.price *
          (1 - c.product.discountPercentage / 100);
    }

    total = double.parse(total.toStringAsFixed(2));

    return {'totalItems': items.toDouble(), 'totalPrice': total};
  }

  void recalc(List<CartEntity> cart) {
    state = _calculateTotals(cart);
  }
}

@riverpod
class CartQuantity extends _$CartQuantity {
  @override
  Map<int, int> build() {
    return {};
  }

  void increment(int productId, int stock) {
    final current = state[productId] ?? 1;
    state = {...state, productId: (current + 1).clamp(1, stock)};
  }

  void decrement(int productId) {
    final current = state[productId] ?? 1;
    if (current > 1) {
      state = {...state, productId: current - 1};
    }
  }

  int getQuantity(int productId) {
    return state[productId] ?? 1;
  }

  void setQuantity(int productId, int quantity, int stock) {
    state = {...state, productId: quantity.clamp(1, stock)};
  }
}
