import 'package:clickbuy/src/config/helper/app_formate.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:clickbuy/src/presentation/screens/cart/widgets/product_cart.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/appbar_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(color: Colors.white),
                titlePadding: const EdgeInsets.all(0),
                title: AppbarShared(),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    ProductCart(),
                    // Text('asdasdasd'),
                    SizedBox(height: 120),
                  ],
                );
                // Text('data');
              }, childCount: 1),
            ),
          ],
        ),
        // Resumen fijo abajo
        ContainerPayInfo(),
      ],
    );
  }
}

class ContainerPayInfo extends StatelessWidget {
  const ContainerPayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = ref.read(loginProvider.notifier).getUser();

    final user = context.read<AuthCubit>().getUser();

    if (user == null) return SizedBox();

    // final quantity = ref.read(cartProvider.notifier).getTotalItems(user!.id);

    // final totalItems = ref.watch(cartTotalsProvider);

    // final totalItems = context.read<CartCubit>().state;

    Map<String, double>? lastTotals;

   

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
             final totals = state.maybeWhen(
              data: (items, totals, quantities) {
                lastTotals =  totals;
                return totals;
              },
              orElse: () => {'totalItems': lastTotals?['totalItems'] ?? 0 , 'totalPrice': lastTotals?['totalPrice']?? 0},
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Resumen de la compra
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${totals['totalItems']} Artículos",
                      style: const TextStyle(fontSize: 16),
                    ),

                    Text(
                      AppFormatter.currency(totals['totalPrice'] ?? 0) ,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Botón de pagar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción de pago
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Pagar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
