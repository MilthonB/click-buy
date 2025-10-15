import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:easy_localization/easy_localization.dart';
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
          child: Text('login_button'.tr(), style: TextStyle(fontSize: 15)),
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
              'welcome_back'.tr(),
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
                // "Nombre: ${user.name} ",
                "name_label".tr(),
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



