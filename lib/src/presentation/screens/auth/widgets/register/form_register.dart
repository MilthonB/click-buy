
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/screens/auth/widgets/shared/bloc_consumer_widget.login.dart';
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
          decoration: _inputDecoration("Nombre completo", Icons.person),
        ),
        const SizedBox(height: 20),
        // Email
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Correo electrónico", Icons.email),
        ),
        const SizedBox(height: 20),
        // Contraseña
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Contraseña", Icons.lock),
        ),
        const SizedBox(height: 20),
        // Confirmar contraseña
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration(
            "Confirmar contraseña",
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
            child: Text('Registrarse'),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¿Ya tienes cuenta?",
              style: TextStyle(color: Colors.white70),
            ),
            TextButton(
              onPressed: () {
                // aquí iría la navegación al login
                context.go('/login');
              },
              child: const Text(
                "Inicia sesión",
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    await context.read<AuthCubit>().signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}
