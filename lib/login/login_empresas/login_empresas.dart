import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nucleo/components/color.dart';
import '../../controllers/login_controller.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import 'login_form_layout.dart'; // Importa o novo serviço de login

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool visivelSenha = true;

  @override
  void initState() {
    super.initState();
    verToken();
  }

  void verSenha() {
    setState(() {
      visivelSenha = !visivelSenha;
    });
  }

  verToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null && kDebugMode) {
      print('Token: $token');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
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