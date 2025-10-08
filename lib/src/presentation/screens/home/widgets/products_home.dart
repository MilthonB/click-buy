import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:clickbuy/src/presentation/provider/products/products_provider.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/detail_product_dialog_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/rating_starts_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/responsive_grid_view_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/secction_title_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shimmer_product_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsHome extends ConsumerWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(getProductsProvider);

    ref.watch(cartProvider);
    ref.watch(cartQuantityProvider);

    return productsAsync.when(
      data: (products) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SecctionTitleShared(nameSection: 'Productos', seeMore: ''),
            ResponsiveGridView(
              items: products,
              columnWidth: 200,
              mainAxisExtent: 530,
              itemBuilder: (context, index) => ProductCard(product: products[index]),
            ),
          ],
        ),
      ),
      loading: () => ShimmerProductShared(),
      error: (_, __) => const Center(child: Text('Error al cargar productos')),
    );
  }
}

class ProductCard extends ConsumerWidget {
  final dynamic product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(cartQuantityProvider.notifier).getQuantity(product.id);

    void handleAddToCart() {
      final user = ref.read(loginProvider.notifier).getUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Para agregar productos es necesario iniciar sesión'),
            duration: Duration(seconds: 5),
          ),
        );
        return;
      }

      ref.read(cartProvider.notifier).addToCart(user.id, product, quantity: quantity);
      ref.read(cartQuantityProvider.notifier).setQuantity(product.id, 1, product.stock);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal,
          content: Text('Agregaste ${product.title} al carrito'),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              onTap: () => showProductBottomSheet(context, ref, product.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imagen,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Título
            Text(
              product.title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),

            // Precio y descuento
            Row(
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(width: 8),
                if (product.discountPercentage > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "-${product.discountPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),

            // Rating
            RatingStars(rating: product.rating),
            const SizedBox(height: 4),

            // Stock
            Text("Stock: ${product.stock}", style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),

            // Descripción
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 10),

            // Cantidad y agregar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuantityButton(product: product, quantity: quantity),
                ElevatedButton(
                  onPressed: handleAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Agregar", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class QuantityButton extends ConsumerWidget {
  final dynamic product;
  final int quantity;
  const QuantityButton({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.white),
          onPressed: () =>
              ref.read(cartQuantityProvider.notifier).decrement(product.id),
        ),
        Text('$quantity', style: const TextStyle(color: Colors.white, fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () => ref
              .read(cartQuantityProvider.notifier)
              .increment(product.id, product.stock),
        ),
      ],
    );
  }
}
