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

  Future createSpecified({
  String? name,
  email,
  password,
  cpf,
 // seguimento,
 // telefone,
 // celular,
 // endereco,
 // numero,
 // bairro,
 // cidade,
 // estado,
  Uint8List? bytes,
}) async {
  /*if (bytes == null) {
    throw ArgumentError('A imagem é obrigatória');
  }*/

String image = base64.encode(bytes!);

  var url = Uri.parse("https://apicasadecor.com/api/cadastro/especificador/");

  Map<String, dynamic> body = {
    "foto": image,
    "nome": name,
    "email": email,
    "password": password,
    "cpf": cpf,
   /* "seguimento": seguimento,
    "telefone": telefone,
    "celular": celular,
    "endereco": endereco,
    "numero": numero,
    "bairro": bairro,
    "cidade": cidade,
    "estado": estado*/
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

Future<bool> updateEspecificador({
    int? id, // Adicione o parâmetro do ID do especificador a ser atualizado.
    //String? name,
   // email,
    cpf,
    seguimento,
    telefone,
    celular,
    endereco,
    numero,
    bairro,
    cidade,
    estado,
    Uint8List? bytes,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print('TOKEN ${token}');

    // Codificar a imagem em base64 se for fornecida.
   // String image = base64.encode(bytes!);

    // Use a URL fornecida para o PATCH com o ID do especificador a ser atualizado.
    var url = Uri.parse("https://apicasadecor.com/api/especificador/editar/$id/");
    Map<String, String> headers = {
      'Authorization': "Token $token",
    };

    // Crie um mapa apenas com os campos que precisam ser atualizados.
    Map<String, dynamic> body = {
      //"nome": name,
      //"email": email,
      "cpf": cpf,
      "seguimento": seguimento,
      "telefone": telefone,
      "celular": celular,
      "endereco": endereco,
      "numero": numero,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado,
    };

    // Remova campos com valor nulo para evitar enviar valores vazios na atualização.
    body.removeWhere((key, value) => value == null);

    try {
      var response = await http.patch(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) { // Altere o status code conforme a API retornar.
        if (kDebugMode) {
          print(response.body);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

   Future<bool> deleteUsuario(int id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  print('TOKEN $token');

  // Use a URL fornecida para a requisição DELETE com o ID do usuário a ser excluído.
  var url = Uri.parse("https://apicasadecor.com/api/usuario/$id/");
  Map<String, String> headers = {
    'Authorization': "Token $token",
  };

  try {
    var response = await http.delete(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) { // Altere o status code conforme a API retornar.
      if (kDebugMode) {
        print("Usuário excluído com sucesso");
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}
}