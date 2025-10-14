import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlocConsumerWidget extends StatelessWidget {
  final  Widget Function(BuildContext context, AuthState  state) builder;
  const BlocConsumerWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          data: (user) {
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (user != null) context.go('/home-screen');
            context.read<CartCubit>().loadCart(user!.id);
          },
          singUp: (isRegister) {
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (isRegister) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.teal,
                  content: Text(
                    'Tu registro fue exitoso ahora puedes iniciar sesion',
                  ),
                ),
              );
              context.go('/login');
            }

            SnackBar(
              backgroundColor: Colors.teal,
              content: Text('Hubo problemas en el registros'),
            );
          },
          error: (message) {
            if (Navigator.canPop(context)){
              Navigator.pop(context); // cerrar loader
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $message')));
          },
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          },
          orElse: () {},
        );
      },
      builder: builder,
    );
  }
}