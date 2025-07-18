import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../routes.dart';

class AuthService {
  final BuildContext context;
  final String email;
  final String senha;

  AuthService({
    required this.context,
    required this.email,
    required this.senha,
  });

 fazerLogin() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse('https://apicasadecor.com/login/');

  Map<String, dynamic> body = {
    'username': email,
    'password': senha,
  };
  var response = await http.post(
    url,
    body: body,
  );

  if (response.statusCode == 200) {
    String token = jsonDecode(response.body)['token'];
    if (kDebugMode) {
      print('Token api: $token');
    }
    if (token.isNotEmpty) {
      await sharedPreferences.setString('token', "Token $token");
      await _buscarUsuarioETrocarRota(token); // ✅ CHAMANDO AQUI
    }
    return true;
  } else {
    return false;
  }
}


  Future<void> _buscarUsuarioETrocarRota(String token) async {
  var url = Uri.parse('https://apicasadecor.com/api/usuario/1');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      String segmento = userData['seguimento'] ?? '';
      String tipo = userData['tipo'] ?? '';

      if (kDebugMode) {
        print('Seguimento: $segmento');
        print('Tipo: $tipo');
      }

      if (segmento.toUpperCase() == 'ADMIN') {
        Navigator.pushReplacementNamed(context, Routes.homeadministrador);
      } else if (tipo.toUpperCase() == 'EMPRESA') {
        Navigator.pushReplacementNamed(context, Routes.homeempresas);
      } else if (tipo.toUpperCase() == 'ESPECIFICADOR') {
        Navigator.pushReplacementNamed(context, Routes.homeespecificador);
      } else {
        _mostrarErro("Tipo de usuário não reconhecido.");
        Navigator.pushReplacementNamed(context, Routes.loginview);
      }
    } else {
      _mostrarErro("Erro ao buscar dados do usuário.");
    }
  } catch (e) {
    _mostrarErro("Erro ao buscar usuário: $e");
  }
}

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }
}
