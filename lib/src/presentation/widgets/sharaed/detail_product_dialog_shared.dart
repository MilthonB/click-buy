import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:clickbuy/src/presentation/provider/products/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showProductBottomSheet(
  BuildContext context,
  WidgetRef ref,
  int idProduct,
) async  {


  try {
  final product = await ref.read(procutByIdProvider(idProduct).future);

     showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen + Descuento en burbuja
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child:
                            //                     FadeInImage.assetNetwork(
                            //   placeholder: 'assets/loading.gif',
                            //   image: 'https://www.dsca.gob.es/sites/default/files/Fotolia_45826714_XXL%20recortada_0.jpg',
                            //   fit: BoxFit.cover,
                            // )
                            Image.network(
                              product.imagen,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "-${product.discountPercentage.toStringAsFixed(0)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nombre + Precio
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // SKU + Stock
                   Text(
                    "SKU: ${product.sku}",
                    style: TextStyle(color: Colors.grey),
                  ),
                   Text(
                    "Stock: ${product.stock} unidades",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 12),

                  // Rating con estrellas

                   Row(
                            children: List.generate(5, (index) {
                              if (index < product.rating.floor()) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              } else if (index < product.rating) {
                                return const Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }
                            }),
                          ),
                  // Row(
                  //   children: List.generate(
                  //     5,
                  //     (index) =>
                  //         const Icon(Icons.star, color: Colors.amber, size: 20),
                  //   ),
                  // ),

                  const SizedBox(height: 12),

                  // Tags como badges
                  
                  // Wrap(
                  //   spacing: 8,
                  //   children: [
                  //     Chip(
                  //       label: const Text("Orgánico"),
                  //       backgroundColor: Colors.green.shade50,
                  //     ),
                  //     Chip(
                  //       label: const Text("Novedad"),
                  //       backgroundColor: Colors.blue.shade50,
                  //     ),
                  //     Chip(
                  //       label: const Text("Popular"),
                  //       backgroundColor: Colors.orange.shade50,
                  //     ),
                  //   ],
                  // ),

                  const SizedBox(height: 16),

                  // Descripción
                  const Text(
                    "Descripción:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                   Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  const SizedBox(height: 20),

                  // Selector de cantidad + botón agregar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cantidad
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(Icons.remove_circle_outline),
                      //     ),
                      //     const Text(
                      //       "1",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(Icons.add_circle_outline),
                      //     ),
                      //   ],
                      // ),
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


                                        final quantity = ref.read(cartQuantityProvider.notifier).getQuantity(product.id);


                                        // si todo sale bien mostrar mensaje 
                                        ref
                                            .read(cartProvider.notifier)
                                            .addToCart(user.id, product, quantity: quantity );

                                         ref.read(cartQuantityProvider.notifier).setQuantity(product.id, 1, product.stock);
                                         ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.teal,
                                              content: Text(
                                                'Agregaste ${product.title} al carrito',
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
            ),
          );
        },
      );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ocurrió un error al cargar el producto')),
    );
  }

 
    
}
