// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChecagemPage extends StatefulWidget {
  const ChecagemPage({Key? key}) : super(key: key);

  @override
  State<ChecagemPage> createState() => _ChecagemPageState();
}

class _ChecagemPageState extends State<ChecagemPage> {
  StreamSubscription? streamSubscription;

  verToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      if (kDebugMode) {
        print('Token $token');
      }
      Navigator.pushNamed(context, Routes.lancamentos);
    } else {
      if (kDebugMode) {
        print('Token $token');
      }
      Navigator.pushNamed(context, Routes.loginview);
    }
  }

  @override
  initState() {
    super.initState();
    verToken();

    /* streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, Routes.loginview);
      } else {
        Navigator.pushNamed(context, Routes.homescreen);
      }
    });*/
  }

  /* @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
