import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_state.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/rating_starts_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showProductBottomSheet(
  BuildContext context,
  // WidgetRef ref,
  int idProduct,
) async {
  try {
    // final product = await ref.read(procutByIdProvider(idProduct).future);

    final productDetailCubit = context.read<ProductDetailCubit>();

    await productDetailCubit.getProductById(idProduct);
    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return BlocBuilder<ProductDetailCubit, ProductsState>(
          builder: (context, state) {
            return state.maybeWhen(
              productLoaded: (product) =>
                  ProductBottomSheetContent(product: product),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text(message)),
              orElse: () => const SizedBox.shrink(),
            );
          },
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ocurrió un error al cargar el producto')),
    );
  }
}

class ProductBottomSheetContent extends StatelessWidget {
  final dynamic product;
  const ProductBottomSheetContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageDiscount(product: product),
            const SizedBox(height: 16),
            ProductTitlePrice(product: product),
            const SizedBox(height: 8),
            Text(
              "SKU: ${product.sku}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "Stock: ${product.stock} unidades",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            RatingStars(rating: product.rating),
            const SizedBox(height: 16),
            const Text(
              "Descripción:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              product.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            BlocBuilder<QuantityCubit, Map<int, int>>(
              builder: (context, state) {
                final quantity = state[product.id] ?? 1;
                return AddToCartButton(product: product, quantity: quantity);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImageDiscount extends StatelessWidget {
  final dynamic product;
  const ProductImageDiscount({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "-${product.discountPercentage.toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductTitlePrice extends StatelessWidget {
  final dynamic product;
  const ProductTitlePrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "\$${product.price}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final dynamic product;
  final int quantity;
  const AddToCartButton({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
  state.maybeWhen(
    loading: () {
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true, // 👈 importante
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    },
    data: (items, totals, quantities) {
      // 👇 cerrar el loading
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado'), backgroundColor: Colors.teal),
      );

      // 👇 cerrar el BottomSheet
      if (Navigator.canPop(context)) Navigator.pop(context);
    },
    error: (message) {
      // 👇 cerrar el loading
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    },
    orElse: () {},
  );
},

child:Center(
      child: ElevatedButton(
        onPressed: () {
          // final user = ref.read(loginProvider.notifier).getUser();
          final user = context.read<AuthCubit>().getUser();

          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Para agregar productos es necesario iniciar sesión',
                ),
                duration: Duration(seconds: 5),
              ),
            );
            return;
          }

          context.read<CartCubit>().addToCart(
            user.id,
            product,
            quantity: quantity,
          );
          context.read<QuantityCubit>().setQuantity(
            product.id,
            1,
            product.stock,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              content: Text('Agregaste ${product.title} al carrito'),
              duration: const Duration(seconds: 3),
            ),
          );

          // if (Navigator.canPop(context)) Navigator.pop(context);
        },
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
      ),
    ) ,
    );
    
  }
}
