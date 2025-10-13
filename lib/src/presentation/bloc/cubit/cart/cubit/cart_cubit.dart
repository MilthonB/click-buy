import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/cart_repositorie.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepositorie _repositorie;
  CartCubit(this._repositorie) : super(CartState.initial());

  Future<void> loadCart(String userId) async {
    emit(CartState.loading());
    try {
      // final datasource = ref.read(cartDatasourcesProvider);
      final items = await _repositorie.getCartItems(userId: userId);
      final totals = _calculateTotals(items);
      final quantities = _extractQuantities(items);
      if (isClosed) return;
      emit(
        CartState.data(items: items, totals: totals, quantities: quantities),
      );
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  Future<void> addToCart(
    String userId,
    ProductEntity product, {
    int quantity = 1,
  }) async {
    emit(CartState.loading());
    try {
      await _repositorie.addProduct(
        userId: userId,
        product: product,
        quantity: quantity,
      );

      // unawaited(loadCart(userId));
      // emit(CartState)
      await loadCart(userId);
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  Future<void> removeFromCart(String userId, dynamic product) async {
    emit(CartState.loading());
    try {
      await _repositorie.removeProduct(userId: userId, product: product);
      await loadCart(userId);
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  Future<void> updateQuantity(
    String userId,
    dynamic product,
    int quantity,
  ) async {
    emit(CartState.loading());
    try {
      await _repositorie.updateQuantity(userId: userId, product: product, quantity:quantity );
      await loadCart(userId);
    } catch (e) {

      emit(CartState.error(e.toString()));
    }
  }

  Future<void> clearCart(String userId) async {
    emit(CartState.loading());
    try {
      await _repositorie.clearCart(userId: userId);
      emit(CartState.data(items: [], totals: {}, quantities: {}));
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  Future<double> getTotal(String userId) async {
    try {
      return await _repositorie.getTotal(userId: userId);
    } catch (e) {
      return 0.0;
    }
  }

  Future<int> getTotalItems(String userId) async {
    try {
      return await _repositorie.getTotalItems(userId: userId);
    } catch (e) {
      return 0;
    }
  }



  Map<int, int> _extractQuantities(List<CartEntity> carts) {
    return {for (var cart in carts) cart.product.id: cart.quantity};
  }

  Map<String, double> _calculateTotals(List<CartEntity> carts) {
    int items = 0;
    double total = 0;

    for (var cart in carts) {
      items += cart.quantity;
      total +=
          cart.quantity *
          cart.product.price *
          (1 - cart.product.discountPercentage / 100);
    }

    total = double.parse(total.toStringAsFixed(2));

    return {'totalItems': items.toDouble(), 'totalPrice': total};
  }


  void recalc(List<CartEntity> cart) {

    state.maybeWhen(
      data: (items, totals, quantities) {
      final totalsRec = _calculateTotals(items);
        emit(CartState.data(items: items, totals: totalsRec, quantities: quantities));
      },
      orElse: () {},
    );

  }
}



// quantity_cubit.dart
class QuantityCubit extends Cubit<Map<int, int>> {
  QuantityCubit() : super({});

  void increment(int productId, int stock) {
    final current = state[productId] ?? 1;
    emit({...state, productId: (current + 1).clamp(1, stock)});
  }

  void decrement(int productId) {
    final current = state[productId] ?? 1;
    emit({...state, productId: (current - 1).clamp(1, current)});
  }

  void setQuantity(int productId, int value, int stock) {
    emit({...state, productId: value.clamp(1, stock)});
  }

  int getQuantity(int productId) => state[productId] ?? 1;

  void clearQuantity(int productId) {
    final newState = Map<int, int>.from(state)..remove(productId);
    emit(newState);
  }
}
