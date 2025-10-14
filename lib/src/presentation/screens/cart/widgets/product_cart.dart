import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:clickbuy/src/presentation/screens/cart/widgets/cards_products_widget.cart.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().getUser();

    if (user != null) {
      Future.microtask(() {
        if (!mounted) return;
        context.read<CartCubit>().loadCart(user.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().getUser();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return state.maybeWhen(
          data: (cartData, total, quantity) {
            return _GridProducts(user: user, cartData: cartData);
          },
          loading: () {
            return ShimmerProductShared();
          },
          error: (error) => ErrorMessageShared(message: error),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

class _GridProducts extends StatelessWidget {
  const _GridProducts({required this.user, required this.cartData});

  final UserEntity? user;
  final List<CartEntity> cartData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SecctionTitleShared(nameSection: 'Productos'),
          ResponsiveGridView(
            items: cartData,
            columnWidth: 200,
            mainAxisExtent: 470,
            itemBuilder: (context, index) {
              final cart = cartData[index];
              final subtotal =
                  cart.quantity *
                  cart.product.price *
                  (1 - cart.product.discountPercentage / 100);

              return CardsProductsWidgetCart(cart: cart, subtotal: subtotal, user: user);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}


