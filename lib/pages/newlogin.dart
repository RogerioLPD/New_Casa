// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/color.dart';
import '../../routes.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route<dynamic> route) => false);
          return true;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWideScreen = constraints.maxWidth >= 800;

            Widget loginContent = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Grupo.png',
                  width: isWideScreen ? 300 : 200,
                  height: isWideScreen ? 160 : 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.loginadministrador),
                  child: Text(
                    'LOGIN ADMINISTRADOR',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 24,
                      color: textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.loginview),
                  child: Text(
                    'LOGIN EMPRESAS',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 24,
                      color: textPrimary,
                    ),
                  ),
                ),
              ],
            );

            if (isWideScreen) {
              // Layout para web (largura >= 800)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/Grupo.png',
                          width: 500,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: loginContent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Layout para dispositivos menores
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: loginContent,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
