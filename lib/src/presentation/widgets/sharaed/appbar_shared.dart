import 'package:animate_do/animate_do.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarShared extends StatelessWidget {
  const AppbarShared({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SizedBox(child: Appbar()));
  }
}

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    // final loginConfirm = ref.watch(loginProvider);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          data: (user) {
            if (user != null) return UserLogin(dataUser: user);
            return NoLoginAppBar();
          },

          orElse: () => SizedBox.shrink(),
        );
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
          child: Text('auth.login_button'.tr(), style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}

class UserLogin extends StatelessWidget {
  final UserEntity dataUser;
  const UserLogin({super.key, required this.dataUser});

  @override
  Widget build(BuildContext context) {
    // cargar los datos de usuario
    // context.read<CartCubit>().loadCart(dataUser.id);
    int? lastTotalItem;
    return Row(
      children: [
        GestureDetector(
          onTap: () => showUserDialog(context, dataUser),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              dataUser.name[0],
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
              'profile.welcome_back'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            Text(
              dataUser.name,
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
        SizedBox(width: 50),
        Spacer(),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final totalItems = state.maybeWhen(
              data: (items, totals, quantities) {
                lastTotalItem = totals['totalItems']?.toInt() ?? 0;
                return lastTotalItem;
              },
              orElse: () => lastTotalItem ?? 0,
            );
            return InkWell(
              onTap: () {
                context.go('/cart');
              },
              child: Badge(
                label: FadeInDown(
                  key: ValueKey(totalItems),
                  duration: const Duration(milliseconds: 400),
                  // infinite: true,
                  child: Text(
                    '$totalItems',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black45,
                ),
              ),
            );
          },
        ),

        SizedBox(width: 20),
      ],
    );
  }
}

void showUserDialog(BuildContext context, UserEntity user) {
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
                child: Icon(Icons.exit_to_app, size: 50),
              ),
              const SizedBox(height: 15),
              Text(
                "profile.name_label".tr(args: [user.name]),
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
                    // ref.read(loginProvider.notifier).logout();

                    context.read<AuthCubit>().logout();

                    Navigator.pop(context); // Cierra el diálogo

                    context.go('/home-screen');

                    // cerrar sesion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "profile.logout_button".tr(),
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
