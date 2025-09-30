import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarShared extends StatelessWidget {
  const AppbarShared({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: SizedBox(child: Appbar()),
    );
  }
}

class Appbar extends ConsumerWidget {
  
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginConfirm = ref.watch(loginProvider);

    return loginConfirm.when(
      data: (user) {
        if (user != null) return UserLogin(dataUser: user,ref: ref,);

        return NoLoginAppBar();
      },
      error: (error, stackTrace) {
        return Text('');
      },
      loading: () {
        return Text('');
      },
    );
  }
}

class NoLoginAppBar extends StatelessWidget {
  const NoLoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.shopping_bag, color: Colors.blue.shade200),
            Text(
              'Click Buy',
              style: GoogleFonts.michroma(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    
        Spacer(),
    
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            context.go('/login');
            // showProductBottomSheet(context);
          },
          child: Text('Iniciar sesion', style: TextStyle(fontSize: 15)),
        ),
    
      ],
    );
  }
}

class UserLogin extends ConsumerWidget {
  final UserEntity dataUser;
  final WidgetRef ref;
  const UserLogin({super.key, required this.dataUser, required this.ref});



  @override
  Widget build(BuildContext context,WidgetRef ref) {
 
    // final totalItemsAsync = ref.watch(totalItemsProvider(dataUser.id));


    final totalItems = ref.watch(cartTotalsProvider);

    return Row(
      children: [
        GestureDetector(
          onTap: () => showUserDialog(context, dataUser, ref),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${dataUser.name[0]}',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
    
        
    
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido de nuevo',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            Text(
              '${dataUser.name}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
        children: [
          Icon(Icons.shopping_bag, color: Colors.blue.shade200),
          Text(
            'Click Buy',
            style: GoogleFonts.michroma(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
        SizedBox(width: 50,),
        Spacer(),
        InkWell(
          onTap: () {
            context.go('/cart');
          },
          child: Badge(
            label: Text('${totalItems['totalItems']}'),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.black45),
          ),
        ),

        SizedBox(width: 20,)
      ],
    );
  }
}

void showUserDialog(BuildContext context, UserEntity user, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                child: Icon(Icons.exit_to_app, size: 50,)
              ),
              const SizedBox(height: 15),
              Text(
                "Nombre: ${user.name} ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
               user.email,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    ref.read(loginProvider.notifier).logout();

                    Navigator.pop(context); // Cierra el diálogo


                    // cerrar sesion 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Cerrar sesión",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showProductBottomSheet(BuildContext context) {
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
                          "https://www.dsca.gob.es/sites/default/files/Fotolia_45826714_XXL%20recortada_0.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                      child: const Text(
                        "-20%",
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
                children: const [
                  Expanded(
                    child: Text(
                      "Nombre del Producto",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "\$250.00",
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
              const Text(
                "SKU: PROD-12345",
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                "Stock: 12 unidades",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 12),

              // Rating con estrellas
              Row(
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                ),
              ),

              const SizedBox(height: 12),

              // Tags como badges
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: const Text("Orgánico"),
                    backgroundColor: Colors.green.shade50,
                  ),
                  Chip(
                    label: const Text("Novedad"),
                    backgroundColor: Colors.blue.shade50,
                  ),
                  Chip(
                    label: const Text("Popular"),
                    backgroundColor: Colors.orange.shade50,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Descripción
              const Text(
                "Descripción:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Este es un producto increíble con gran calidad, "
                "perfecto para tu día a día.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Selector de cantidad + botón agregar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cantidad
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Agregar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
