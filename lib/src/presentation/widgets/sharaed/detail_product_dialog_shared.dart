import 'package:clickbuy/src/presentation/widgets/sharaed/dialog_add_product_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/quantity_buttons_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/snackbar_helper_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_state.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/rating_starts_shared.dart';



Future<void> showProductBottomSheet(BuildContext context, int idProduct) async {
  final productCubit = context.read<ProductDetailCubit>();

  await productCubit.getProductById(idProduct);
  if (!context.mounted) return;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return BlocBuilder<ProductDetailCubit, ProductsState>(
        builder: (_, state) => state.maybeWhen(
          productLoaded: (product) => ProductBottomSheetContent(product: product),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          orElse: () => const SizedBox.shrink(),
        ),
      );
    },
  );
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
            _ProductImageDiscount(product: product),
            const SizedBox(height: 16),
            _ProductTitlePrice(product: product),
            const SizedBox(height: 8),
            Text("SKU: ${product.sku}", style: const TextStyle(color: Colors.grey)),
            Text('products.stock'.tr(namedArgs: {'quantity':product.stock.toString()}), style: const TextStyle(color: Colors.grey)),
            // Text("Stock: ${product.stock} unidades", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            RatingStars(rating: product.rating),
            const SizedBox(height: 16),
            Text("products.description_label".tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(product.description, style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 20),
            BlocBuilder<QuantityCubit, Map<int, int>>(
              builder: (context, state) {
                final quantity = state[product.id] ?? 1;
                return _AddToCartSection(product: product, quantity: quantity);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class _AddToCartSection extends StatelessWidget {
  final dynamic product;
  final int quantity;
  const _AddToCartSection({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () => LoadingDialog.show(context, product: product, quantity: quantity),
          data: (_, __, ___) {
            LoadingDialog.hide(context);
            SnackbarHelper.success(
              context,
              'products.added_to_cart'.tr(namedArgs: {'product': product.title, 'quantity':quantity.toString()})
              // 'Agregaste ${product.title} x $quantity al carrito',
            );
            Navigator.pop(context); // cerrar el bottom sheet
          },
          error: (msg) {
            LoadingDialog.hide(context);
            SnackbarHelper.error(context, msg);
          },
          orElse: () {},
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuantityButton(product: product, quantity: quantity),
          ElevatedButton(
            onPressed: () {
              final user = context.read<AuthCubit>().getUser();
              if (user == null) {
                SnackbarHelper.error(context, 'products.login_required'.tr());
                return;
              }
              context.read<CartCubit>().addToCart(user.id, product, quantity: quantity);
              context.read<QuantityCubit>().setQuantity(product.id, 1, product.stock);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("products.add_to_cart_button".tr(), style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _ProductImageDiscount extends StatelessWidget {
  final dynamic product;
  const _ProductImageDiscount({required this.product});

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
        if (product.discountPercentage != null)
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

class _ProductTitlePrice extends StatelessWidget {
  final dynamic product;
  const _ProductTitlePrice({required this.product});

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



