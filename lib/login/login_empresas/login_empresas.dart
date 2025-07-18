import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nucleo/components/color.dart';
import '../../controllers/login_controller.dart';
import '../../routes.dart';
import '../../services/auth_service.dart'; // Importa o novo serviço de login

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
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route<dynamic> route) => false);
          return true;
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.jpg',
                    width: 460,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'LOGIN EMPRESAS',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 28,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Insira seu e-mail',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.mail_outlined,
                        color: Color(0xFF3A3A3A),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu e-mail';
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return 'Digite um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    obscureText: visivelSenha,
                    controller: _senhaController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Insira sua senha',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(visivelSenha
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: verSenha,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      elevation: 0,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final authService = AuthService(
                            context: context,
                            email: _emailController.text,
                            senha: _senhaController.text,
                          );
                          await authService.fazerLogin();
                        }
                      },
                      child: Text(
                        'ENTRAR',
                        style: GoogleFonts.montserrat(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Não tem uma conta? ",
                          style: GoogleFonts.montserrat(
                            color: textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: 'Registre-se',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Routes.registerempresas);
                            },
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      elevation: 0,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                      child: Text(
                        'VOLTAR',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF3A3A3A),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
