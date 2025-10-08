import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/presentation/provider/products/products_provider.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/detail_product_dialog_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shimmer_carrusel_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ProductosSlideshow extends ConsumerWidget {
  const ProductosSlideshow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProductsCarruselProvider);

    return products.when(
      data: (product) {
        return SizedBox(
          width: 1200,
          child: SizedBox(
            height: 210,
            width: double.infinity,
            child: Swiper(
              viewportFraction: 0.8,
              scale: 0.9,
              itemCount: product.length,
              autoplay: true,
              itemBuilder: (context, index) {
                return _Slider(product: product[index]);
              },
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Text('data$error');
      },
      loading: () {
        // Supongamos que queremos mostrar 3 slides de shimmer
        return ShimmerCarruselShared();
      },
    );
  }
}

class _Slider extends ConsumerWidget {
  final ProductEntity product;
  const _Slider({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final decorator = BoxDecoration(
    //   borderRadius: BorderRadius.circular(20),
    //   boxShadow: const [
    //     BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
    //   ],
    // );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
          gradient: const LinearGradient(
            colors: [
              Colors.blue, // color inicial
              Colors.teal, // color final
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showProductBottomSheet(context, ref, product.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.imagen,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.black12),
                      );
                    }
                    // return Placeholder();
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 120,
                  child: Text(
                    '${product.title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
