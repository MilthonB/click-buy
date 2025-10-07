import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:clickbuy/src/presentation/provider/products/products_provider.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/detail_product_dialog_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/responsive_grid_view_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/secction_title_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shimmer_product_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsHome extends ConsumerWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProductsProvider);

    ref.watch(cartProvider);
    ref.watch(cartQuantityProvider);



    return products.when(
      data: (product) {

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecctionTitleShared(
                nameSection: 'Productos',
                seeMore: '',
              ),
              ResponsiveGridView(
                items: product,
                columnWidth: 200,
                mainAxisExtent: 530,
                itemBuilder: (context, index) {
                  print(product[index].rating);
                final quantity = ref.watch(cartQuantityProvider.notifier).getQuantity(product[index].id);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.teal],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen
                          InkWell(
                            onTap: () {
                              showProductBottomSheet(context, ref, product[index].id);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product[index].imagen,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Título
                          Text(
                            product[index].title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Precio y descuento
                          Row(
                            children: [
                              Text(
                                "\$${product[index].price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (product[index].discountPercentage > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-${product[index].discountPercentage.toStringAsFixed(0)}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Rating en estrellas
                          // final currentProduct = product[0]; // el único producto

Row(
  children: List.generate(5, (starIndex) {
    if (starIndex < product[index].rating.floor()) {
      return const Icon(Icons.star, color: Colors.amber, size: 18);
    } else if (starIndex < product[index].rating) {
      return const Icon(Icons.star_half, color: Colors.amber, size: 18);
    } else {
      return const Icon(Icons.star_border, color: Colors.amber, size: 18);
    }
  }),
),
                          // Row(
                          //   children: List.generate(5, (index) {
                          //     if (index < product[index].rating.floor()) {
                          //       return const Icon(
                          //         Icons.star,
                          //         color: Colors.amber,
                          //         size: 18,
                          //       );
                          //     } else if (index < product[index].rating) {
                          //       return const Icon(
                          //         Icons.star_half,
                          //         color: Colors.amber,
                          //         size: 18,
                          //       );
                          //     } else {
                          //       return const Icon(
                          //         Icons.star_border,
                          //         color: Colors.amber,
                          //         size: 18,
                          //       );
                          //     }
                          //   }),
                          // ),

                          const SizedBox(height: 4),

                          // Stock
                          Text(
                            "Stock: ${product[index].stock}",
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 4),

                          // Descripción corta
                          Text(
                            product[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          ref.read(cartQuantityProvider.notifier).decrement(product[index].id);
                                        },
                                      ),
                                      Text(
                                        '$quantity',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          ref.read(cartQuantityProvider.notifier).increment(product[index].id, product[index].stock);
                                        },
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final user = ref
                                            .read(loginProvider.notifier)
                                            .getUser();
                                        if (user == null) {
                                          // tines que inciiar sesion para agregar al carrito
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                'Para agregar productos es necesario iniciar sesion',
                                              ),
                                              duration: Duration(
                                                seconds: 5,
                                              ), // cuánto dura visible
                                            ),
                                          );
                                          return;
                                        }


                                        final quantity = ref.read(cartQuantityProvider.notifier).getQuantity(product[index].id);


                                        // si todo sale bien mostrar mensaje 
                                        ref
                                            .read(cartProvider.notifier)
                                            .addToCart(user.id, product[index], quantity: quantity );

                                         ref.read(cartQuantityProvider.notifier).setQuantity(product[index].id, 1, product[index].stock);
                                         ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.teal,
                                              content: Text(
                                                'Agregaste ${product[index].title} al carrito',
                                              ),
                                              duration: Duration(
                                                seconds: 3,
                                              ), // cuánto dura visible
                                            )
                                            );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Agregar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // ElevatedButton(
                          //       onPressed: () {

                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.orangeAccent,
                          //         foregroundColor: Colors.white,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12)),
                          //       ),
                          //       child: const Text("Agregar"),
                          //     ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Text('');
      },
      loading:() => ShimmerProductShared(),
    );
  }
}
