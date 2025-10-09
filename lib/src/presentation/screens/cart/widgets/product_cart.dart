import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/error_message_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/responsive_grid_view_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/secction_title_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shimmer_product_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ProductCart extends ConsumerStatefulWidget {
  const ProductCart({super.key});

  @override
  ConsumerState<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends ConsumerState<ProductCart> {
  @override
  void initState() {
    super.initState();
    final user = ref.read(loginProvider.notifier).getUser();
    if (user != null) {
      Future.microtask(() {
        ref.read(cartProvider.notifier).loadCart(user.id);
      });
    }
  }

  void _updateTotals() {
    
    final cartAsync = ref.read(cartProvider);
    final cartItems = cartAsync.maybeWhen(
      data: (data) =>
          List<CartEntity>.from(data), // asegura que sea List<CartEntity>
      orElse: () => <CartEntity>[],
    );

    
    ref.read(cartTotalsProvider.notifier).recalc(cartItems);
  }

  @override
  Widget build(BuildContext context) {
    final productsCart = ref.watch(cartProvider);
    // final totals = ref.watch(cartTotalsProvider);
    final user = ref.read(loginProvider.notifier).getUser();

    return productsCart.when(
      data: (products) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SecctionTitleShared(nameSection: 'Productos'),
              ResponsiveGridView(
                items: products,
                columnWidth: 200,
                mainAxisExtent: 430,
                itemBuilder: (context, index) {
                  final product = products[index];

                  // Subtotal del producto
                  final subtotal =
                      product.quantity *
                      product.product.price *
                      (1 - product.product.discountPercentage / 100);

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.product.imagen,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Información del producto
                          Text(
                            product.product.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 4),

                          // Precio y descuento
                          Row(
                            children: [
                              Text(
                                "\$${product.product.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (product.product.discountPercentage > 0)
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
                                    "-${product.product.discountPercentage.toStringAsFixed(0)}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text("Stock: ${product.product.stock}"),
                          const SizedBox(height: 4),
                          Text(
                            "Subtotal: \$${subtotal.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Cantidad y eliminar
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  final userId = user!.id;
                                  if (product.quantity > 1) {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(
                                          userId,
                                          product.product,
                                          product.quantity - 1,
                                        )
                                        .then((_) => _updateTotals());
                                  }
                                },
                              ),
                              Text(
                                "${product.quantity}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  final userId = user!.id;
                                  if (product.quantity <
                                      product.product.stock) {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(
                                          userId,
                                          product.product,
                                          product.quantity + 1,
                                        )
                                        .then((_) => _updateTotals());
                                  }
                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  final userId = user!.id;
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeFromCart(userId, product.product)
                                      .then((_) => _updateTotals());
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Total general debajo de la lista
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        print('Error en el screen: ${error.toString()}');
        return ErrorMessageShared(message: error.toString(), onRetry: () => ref.invalidate(cartProvider),);
      },
      loading: () {
        return ShimmerProductShared();
      },
    );
  }
}
