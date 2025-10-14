import 'package:clickbuy/src/config/helper/app_formate.dart';
import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/screens/cart/widgets/action_product_widget.cart.dart';
import 'package:flutter/material.dart';

class CardsProductsWidgetCart extends StatelessWidget {
  const CardsProductsWidgetCart({
    super.key,
    required this.cart,
    required this.subtotal,
    required this.user,
  });

  final CartEntity cart;
  final double subtotal;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
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
              child: FadeInImage(
                placeholder: AssetImage('assets/loading/loading.gif'), 
                image: NetworkImage(cart.product.imagen)
              )
              // child: Image.network(
              //   cart.product.imagen,
              //   height: 150,
              //   width: double.infinity,
              //   fit: BoxFit.contain,
              // ),
            ),
            const SizedBox(height: 8),
    
            // Información del producto
            Text(
              cart.product.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              cart.product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 4),
    
            // Precio y descuento
            Row(
              children: [
                Text(
                  AppFormatter.currency(cart.product.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                if (cart.product.discountPercentage > 0)
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
                      "-${cart.product.discountPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text("Stock: ${cart.product.stock}"),
            const SizedBox(height: 4),
            Text(
              "Subtotal: ${ AppFormatter.currency(subtotal)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
    
            // Cantidad y eliminar
            ActionsProductCart(user: user, cart: cart),
          ],
        ),
      ),
    );
  }
}
