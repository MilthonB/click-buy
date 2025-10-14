import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityButton extends StatelessWidget {
  final dynamic product;
  final int quantity;

  const QuantityButton({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (quantity > 1) {
              context.read<QuantityCubit>().setQuantity(product.id, quantity - 1, product.stock);
            }
          },
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('$quantity', style: const TextStyle(fontSize: 16)),
        IconButton(
          onPressed: () {
            if (quantity < product.stock) {
              context.read<QuantityCubit>().setQuantity(product.id, quantity + 1, product.stock);
            }
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}