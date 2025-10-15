import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_state.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/snackbar_helper_shared.dart';
import 'package:easy_localization/easy_localization.dart';
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
              SnackbarHelper.success(context, 'register_success'.tr());
              context.go('/login');
            }

            SnackBar(
              backgroundColor: Colors.teal,
              content: Text('register_error'.tr()),
            );
          },
          error: (message) {
            if (Navigator.canPop(context)){
              Navigator.pop(context); // cerrar loader
            }
            SnackbarHelper.error(context, message);
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