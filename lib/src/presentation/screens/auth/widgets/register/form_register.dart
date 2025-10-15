
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/screens/auth/widgets/shared/bloc_consumer_widget.login.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/snackbar_helper_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FormRegister extends StatelessWidget {
  FormRegister({super.key});


  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget(builder: (context, state) => _buildForm(context),);
  }

    InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Nombre
        TextField(
          controller: _nameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("auth.full_name".tr(), Icons.person),
        ),
        const SizedBox(height: 20),
        // Email
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("auth.email_hint".tr(), Icons.email),
        ),
        const SizedBox(height: 20),
        // Contraseña
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("auth.password_hint".tr(), Icons.lock),
        ),
        const SizedBox(height: 20),
        // Confirmar contraseña
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration(
            "auth.confirm_password".tr(),
            Icons.lock_outline,
          ),
        ),
        const SizedBox(height: 30),
        // Botón registrar
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2575FC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
            ),
            onPressed: () => onPressRegister(context),
            child: Text('auth.register_button'.tr()),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "auth.already_have_account".tr(),
              style: TextStyle(color: Colors.white70),
            ),
            TextButton(
              onPressed: () {
                // aquí iría la navegación al login
                context.go('/login');
              },
              child: Text(
                "auth.go_login".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


   void onPressRegister(BuildContext context) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      SnackbarHelper.error(context, 'auth.fill_all_fields'.tr());
      return;
    }

    if (password != confirmPassword) {
      SnackbarHelper.error(context, 'auth.passwords_do_not_match'.tr());
      return;
    }

    await context.read<AuthCubit>().signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}
