import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAuthScreen extends ConsumerWidget {
  LoginAuthScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 700; // breakpoint

              if (isWide) {
                // 💻 Tablet/Web: usar Row
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1000,
                    ), // límite del ancho total
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centra el contenido
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Panel izquierdo
                        // Panel izquierdo
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // centra vertical
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // centra horizontal
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 90,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Bienvenido 👋",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Inicia sesión para continuar con tu experiencia.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 60), // espacio entre columnas
                        // Panel derecho (formulario)
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(40.0),
                                child: _buildForm(context, ref),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // 📱 Celular: usar Column (como antes)
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.black12,
                          child: CircleAvatar(
                            backgroundColor: Colors.black12,
                            radius: 65,
                            child: Center(
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Click Buy",
                          style: GoogleFonts.michroma(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildForm(context, ref),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Correo electrónico",
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.email, color: Colors.white70),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Contraseña",
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.lock, color: Colors.white70),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 30),
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
            onPressed: () => onPressLogin(context, ref),
            child: Text(
              "Iniciar sesión",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: const Text(
            "¿Olvidaste tu contraseña?",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¿No tienes cuenta?",
              style: TextStyle(color: Colors.white70),
            ),
            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text(
                "Regístrate",
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

  void onPressLogin(BuildContext context, WidgetRef ref) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false, // para que no se cierre tocando afuera
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final loginNotifier = ref.read(loginProvider.notifier);

    await loginNotifier.login(email: email, password: password);

    final loginState = ref.read(loginProvider);

    if (Navigator.canPop(context)) Navigator.pop(context);

    loginState.when(
      data: (user) {
        if (user != null) {
          context.go('/home-screen');
        }
      },
      error: (error, stackTrace) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $error')));
      },
      loading: () {},
    );
  }
}
