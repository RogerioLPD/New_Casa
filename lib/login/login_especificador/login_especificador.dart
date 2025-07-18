// ignore_for_file: prefer_interpolation_to_compose_strings


import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/color.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';

import '../../controllers/login_controller.dart';
import '../../routes.dart';
import '../login_empresas/login_form_layout.dart';

class LoginEspecificador extends StatefulWidget {
  const LoginEspecificador({Key? key}) : super(key: key);

  @override
  State<LoginEspecificador> createState() => _LoginEspecificadorState();
}

class _LoginEspecificadorState extends State<LoginEspecificador> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool visivelSenha = true;

  final AuthenticationController auth = AuthenticationController();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    var check = await auth.checkAuthentication();
    if (check) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.homeespecificador);
      }
    }
  }

  void verSenha() {
    setState(() {
      visivelSenha = !visivelSenha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeespecificador, (Route<dynamic> route) => false);
          return true;
        },
        child: LoginLayoutResponsivo(
        formKey: _formKey,
        emailController: _emailController,
        senhaController: _senhaController,
        isSenhaVisivel: !visivelSenha,
        onToggleSenha: verSenha,
        onLoginPressed: () async {
          if (_formKey.currentState!.validate()) {
            final authService = AuthService(
              context: context,
              email: _emailController.text,
              senha: _senhaController.text,
            );
            await authService.fazerLogin();
          }
        },
        onRegistrar: () {
          Navigator.pushNamed(context, Routes.registerempresas);
        },
        onVoltar: () {
          Navigator.pushNamed(context, Routes.home);
        },
      ),
    ),
  );
}
}