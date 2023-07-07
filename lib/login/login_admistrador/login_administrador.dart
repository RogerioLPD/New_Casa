// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nucleo/components/color.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';

class LoginAdministrador extends StatefulWidget {
  const LoginAdministrador({Key? key}) : super(key: key);

  @override
  State<LoginAdministrador> createState() => _LoginAdministradorState();
}

class _LoginAdministradorState extends State<LoginAdministrador> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool visivelSenha = true;

  final AuthenticationController auth = AuthenticationController();

  checkLogin() async {
    var check = await auth.checkAuthentication();
    if (check) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.homeadministrador);
      }
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void verSenha() {
    setState(() {
      visivelSenha = !visivelSenha;
    });
  }

  void getRoute() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .0,
                ),
                Image.asset(
                  'assets/images/Logo.png',
                  width: 460,
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'LOGIN ADMINISTRADOR',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 28,
                      color: textPrimary),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
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
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  obscureText: visivelSenha,
                  controller: _senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Insira sua senha',
                    hintStyle:
                    const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(visivelSenha
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        verSenha();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: MaterialButton(
                //     padding: const EdgeInsets.symmetric(horizontal: 6),
                //     elevation: 0,
                //     onPressed: () {},
                //     child: Text(
                //       'Esqueceu a senha?',
                //       style: GoogleFonts.montserrat(
                //           color: const Color(0xFF3A3A3A)),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 14,
                ),
                StreamBuilder(
                  stream: auth.loginLoading.stream,
                  builder: (_, snapshot) {
                    print(snapshot.data);
                    return snapshot.data == false
                        ? Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 6),
                        elevation: 0,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool logout = await auth.doLogin(
                                _emailController.text,
                                _senhaController.text);
                            if (logout) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, Routes.homeadministrador);
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Erro ao fazer login')),
                              );
                            }
                          }
                        },
                        child: Text(
                          'ENTRAR',
                          style: GoogleFonts.montserrat(
                              color: textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    )
                        : const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () => Navigator.pushNamed(context, Routes.home),
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
      ),),
    );
  }

  Future<bool> fazerLogin() async {
    if (kDebugMode) {
      print("oi");
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url =
        Uri.parse("https://nucleocasadecor-production.up.railway.app/login/");
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    Map<String, dynamic> body = {
      "username": _emailController.text,
      "password": _senhaController.text,
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        if (token.isNotEmpty) {
          await sharedPreferences.setString('token', "Token $token");
        }
        if (kDebugMode) {
          print(sharedPreferences.getString('token'));
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}