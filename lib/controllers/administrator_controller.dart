import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdministradorController {
  createEnterprise(
      {String? name,
      email,
      password,
      cpf,
      seguimento,
      telefone,
      celular,
      endereco,
      numero,
      bairro,
      cidade,
      estado,
      Uint8List? bytes}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print('TOKEN ${token}');
    String image = base64.encode(bytes!);
    var url =
        Uri.parse("https://apicasadecor.com/api/cadastro/empresa/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    Map<String, dynamic> body = {
      "foto": image,
      "nome": name,
      "email": email,
      "password": password,
      "cpf": cpf,
      "tipo": "EMPRESA",
      "seguimento": seguimento,
      "telefone": telefone,
      "celular": celular,
      "endereco": endereco,
      "numero": numero,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado
    };

    try {
      var response = await http.post(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.body);
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

  Future createRearward(
      {String? points,
      String? title,
      String? description,
      Uint8List? bytes}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    String image = base64.encode(bytes!);
    var url = Uri.parse("https://apicasadecor.com/api/premio/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    Map<String, dynamic> body = {
      "imagem_1": image,
      "pontos": points,
      "titulo": title,
      "descricao": description
    };

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.body);
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

  Future createSpecified(
      {String? name,
      email,
      password,
      cpf,
      seguimento,
      telefone,
      celular,
      endereco,
      numero,
      bairro,
      cidade,
      estado,
      Uint8List? bytes
      }) async {

    String image = base64.encode(bytes!);
    var url = Uri.parse("https://apicasadecor.com/api/cadastro/especificador/");
   
    Map<String, dynamic> body = {
      "foto": image,
      "nome": name,
      "email": email,
      "password": password,
      "cpf": cpf,
      "seguimento": seguimento,
      "telefone": telefone,
      "celular": celular,
      "endereco": endereco,
      "numero": numero,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado
    };

    try {
      var response = await http.post(url, body: body);
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.body);
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
