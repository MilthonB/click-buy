import 'package:card_swiper/card_swiper.dart';
import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:clickbuy/src/presentation/screens/cart/widgets/product_cart.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/categories_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/productos_slideshow.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/products_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/search_products_home.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/appbar_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/secction_title_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
         CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
              titlePadding: const EdgeInsets.all(0),
              title: AppbarShared(),
            ),
          ),
      
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  ProductCart(),
                  SizedBox(height: 120,)
                ],
              );
              // Text('data');
            },childCount: 1)
          )
        ],
      ),
     // Resumen fijo abajo
          ContainerPayInfo(),
      ]
    );
  }
}

class ContainerPayInfo extends ConsumerWidget {
  const ContainerPayInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.read(loginProvider.notifier).getUser();

    if(user == null) return SizedBox();

    // final quantity = ref.read(cartProvider.notifier).getTotalItems(user!.id);

    final totalItems = ref.watch(cartTotalsProvider);



    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Resumen de la compra
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(
                  " ${totalItems['totalItems']} Artículos",
                  style: const TextStyle(fontSize: 16),
                ),
               
                Text(
                  "\$${totalItems['totalPrice']}",
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
                child:  Text(
                  "Pagar",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}