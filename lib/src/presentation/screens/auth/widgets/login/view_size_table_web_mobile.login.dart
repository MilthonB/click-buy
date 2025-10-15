import 'package:clickbuy/src/presentation/screens/auth/widgets/login/form_login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTabletWebLogin extends StatelessWidget {
  const ViewTabletWebLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1000,
        ), // límite del ancho total
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // centra el contenido
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Panel izquierdo
            // Panel izquierdo
            Flexible(flex: 1, child: _HeaderAuth()),

            const SizedBox(width: 60), // espacio entre columnas
            // Panel derecho (formulario)
            Flexible(
              flex: 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40.0),
                    child: FormLogin(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderAuth extends StatelessWidget {
  const _HeaderAuth();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // centra vertical
        crossAxisAlignment: CrossAxisAlignment.center, // centra horizontal
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 90, color: Colors.white),
          SizedBox(height: 20),
          Text(
            'auth.welcome_title'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "auth.welcome_message".tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ViewMobileLogin extends StatelessWidget {
  const ViewMobileLogin({super.key});
  @override
  Widget build(BuildContext context) {
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
            FormLogin(),
          ],
        ),
      ),
    );
  }
}
