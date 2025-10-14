import 'package:clickbuy/src/config/helper/app_formate.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_state.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/dialog_add_product_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/quantity_buttons_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/snackbar_helper_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductsHome extends StatelessWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => ShimmerProductShared(),
          loaded: (products) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SecctionTitleShared(
                  nameSection: 'Productos',
                  seeMore: '',
                ),
                ResponsiveGridView(
                  items: products,
                  columnWidth: 200,
                  mainAxisExtent: 530,
                  itemBuilder: (context, index) =>
                      ProductCard(product: products[index]),
                ),
              ],
            ),
          ),
          error: (message) => ErrorMessageShared(message: message),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}


class ProductCard extends StatelessWidget {
  final dynamic product;
  const ProductCard({super.key, required this.product});

  Future<void> _handleAddToCart(BuildContext context, int quantity) async {
    final user = context.read<AuthCubit>().getUser();

    if (user == null) {
      SnackbarHelper.error(
        context,
        'Para agregar productos es necesario iniciar sesión',
      );
      return;
    }

    // Mostrar indicador de carga
    LoadingDialog.show(context, product: product, quantity: quantity);

    try {
      await context.read<CartCubit>().addToCart(user.id, product, quantity: quantity);
      
      context.read<QuantityCubit>().setQuantity(product.id, 1, product.stock);

      LoadingDialog.hide(context);
      SnackbarHelper.success(
        context,
        'Agregaste ${product.title} al carrito',
      );
    } catch (e, s) {
      debugPrint('Error al agregar producto: $e\n$s');
      LoadingDialog.hide(context);
      SnackbarHelper.error(
        context,
        'Ocurrió un error al agregar el producto',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quantity = context.watch<QuantityCubit>().getQuantity(product.id);

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
            InkWell(
              onTap: () => showProductBottomSheet(context, product.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading/loading.gif'),
                  image: NetworkImage(product.imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  AppFormatter.currency(product.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                if (product.discountPercentage > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "-${product.discountPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            RatingStars(rating: product.rating),
            const SizedBox(height: 4),
            Text("Stock: ${product.stock}",
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Column(
              // crossAxisAlignment: WrapCrossAlignment.center,
              // runSpacing: 10,
              children: [
                QuantityButton(product: product, quantity: quantity),
                SizedBox(height: 10,),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, cartState) {
                    final isLoading = cartState.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _handleAddToCart(context, quantity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Agregar",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
  }
}
