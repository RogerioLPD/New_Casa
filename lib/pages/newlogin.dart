// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nucleo/components/color.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
          return true;
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0,
                  ),
                  Image.asset(
                    'assets/images/Nucleo.png',
                    width: 460,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed:() => Navigator.pushNamed(
                              context, Routes.loginadministrador),
                    child: Text(
                      'LOGIN ADMINISTRADOR',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 3,
                          fontSize: 28,
                          color: textPrimary),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                              context, Routes.loginview),
                    child: Text(
                      'LOGIN EMPRESAS',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 3,
                          fontSize: 28,
                          color: textPrimary),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                              context, Routes.loginespecificador),
                    child: Text(
                      'LOGIN ESPECIFICADOR',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 3,
                          fontSize: 28,
                          color: textPrimary),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  
              
                ],
              
              ),
              
          ),
        ),
      ),
    );
  }

}