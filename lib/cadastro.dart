import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EmpresaCadastroScreen extends StatefulWidget {
  const EmpresaCadastroScreen({super.key});

  @override
  State<EmpresaCadastroScreen> createState() => _EmpresaCadastroScreenState();
}

class _EmpresaCadastroScreenState extends State<EmpresaCadastroScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();

  Future<void> cadastrarEmpresa() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String apiUrl = 'https://apicasadecor.com/api/cadastro/empresa/';
    Map<String, String> headers = {
      'Authorization': "Token $token",
    };
    
    Map<String, dynamic> requestData = {
      "email": emailController.text,
      "password": passwordController.text,
      "nome": nomeController.text,
      "cidade": cidadeController.text,
    };

    try {
      var response = await http.post(Uri.parse(apiUrl),
          headers: headers/*{'Content-Type': 'application/json'}*/,
          body: json.encode(requestData));

      if (response.statusCode == 200) {
        // Sucesso - Fazer algo aqui, como exibir uma mensagem de sucesso.
      } else {
        // Erro - Exibir uma mensagem de erro ao usuário.
        print('Erro: ${response.statusCode}');
      }
    } catch (error) {
      // Erro - Exibir uma mensagem de erro ao usuário.
      print('Erro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Empresa'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(
                labelText: 'Cidade',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarEmpresa,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}


