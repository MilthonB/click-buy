import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.data({
    required List<CartEntity> items,
    required Map<String, double> totals,
    required Map<int,int> quantities
  }) = _Data;
  const factory CartState.error(String message) = _Error;
}
