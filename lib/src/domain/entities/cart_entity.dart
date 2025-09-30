import 'package:clickbuy/src/domain/entities/product_entity.dart';

class CartEntity {
  final ProductEntity product;
  int quantity;

  CartEntity({required this.product, this.quantity = 1});
  double get totalPrice => product.price * quantity * (1 - product.discountPercentage / 100);

}
