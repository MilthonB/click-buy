import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';        // <-- obligatorio para que Freezed genere el código

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.loaded(List<ProductEntity> products) = _Loaded;
  const factory ProductsState.productLoaded(ProductEntity product) = _ProductLoaded;
  const factory ProductsState.error(String message) = _Error;
}
  