import 'package:clickbuy/src/presentation/screens/auth/widgets/login/view_size_table_web_mobile.login.dart';
import 'package:flutter/material.dart';

class LoginAuthScreen extends StatelessWidget {
 const LoginAuthScreen({super.key});


  @override
  Widget build(BuildContext context) {
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
                return ViewTabletWebLogin();
              } else {
                return ViewMobileLogin();
              }
            },
          ),
        ),
      ),
    );
  }


}
