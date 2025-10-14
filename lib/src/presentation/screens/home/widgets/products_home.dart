
import 'package:clickbuy/src/config/helper/app_formate.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_state.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shared.dart';
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
          loaded: (products){
            
            return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SecctionTitleShared(nameSection: 'Productos', seeMore: ''),
                ResponsiveGridView(
                  items: products,
                  columnWidth: 200,
                  mainAxisExtent: 530,
                  itemBuilder: (context, index){
                    return ProductCard(product: products[index]);
                  },
                ),
              ],
            ),
          );
          },
          error: (message) {
            return ErrorMessageShared(message: message);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}



class ProductCard extends StatelessWidget {
  final dynamic product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    
    final quantity = context.watch<QuantityCubit>().getQuantity(product.id);

    void handleAddToCart() {

      
      final user = context.read<AuthCubit>().getUser();
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

      context.read<CartCubit>().addToCart(user.id, product, quantity: quantity);
      context.read<QuantityCubit>().setQuantity(product.id, 1, product.stock);

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
            InkWell(
              onTap: () => showProductBottomSheet(context, product.id),

              //Imagen 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: FadeInImage(
                  placeholder: AssetImage('assets/loading/loading.gif'), 
                  image: NetworkImage(product.imagen)
                )
                // child: Image.network(
                //   product.imagen,
                //   height: 150,
                //   width: double.infinity,
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
            const SizedBox(height: 8),
            Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(AppFormatter.currency(product.price), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(width: 8),
                if (product.discountPercentage > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                    child: Text("-${product.discountPercentage.toStringAsFixed(0)}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            RatingStars(rating: product.rating),
            const SizedBox(height: 4),
            Text("Stock: ${product.stock}", style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuantityButton(product: product, quantity: quantity),
                ElevatedButton(
                  onPressed: handleAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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



class QuantityButton extends StatelessWidget {
  final dynamic product;
  final int quantity;
  const QuantityButton({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.white),
          onPressed: () => context.read<QuantityCubit>().decrement(product.id),
        ),
        Text('$quantity', style: const TextStyle(color: Colors.white, fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () => context.read<QuantityCubit>().increment(product.id, product.stock),
        ),
      ],
    );
  }
}

