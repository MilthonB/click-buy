import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsProductCart extends StatelessWidget {
  const ActionsProductCart({
    super.key,
    required this.user,
    required this.cart,
  });

  final UserEntity? user;
  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            final userId = user!.id;
            if (cart.quantity > 1) {
              context.read<CartCubit>().updateQuantity(
                userId,
                cart.product,
                cart.quantity - 1,
              );
            }
          },
        ),
        Text(
          "${cart.quantity}",
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            final userId = user!.id;
            if (cart.quantity < cart.product.stock) {
              context.read<CartCubit>().updateQuantity(
                userId,
                cart.product,
                cart.quantity + 1,
              );
            }
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            final userId = user!.id;
            context.read<CartCubit>().removeFromCart(
              userId,
              cart.product,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Producto eliminado del carrito",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
