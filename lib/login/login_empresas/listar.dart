import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Empresa {
  final String foto;
  final String nome;
  final String cidade;

  Empresa({
    required this.foto,
    required this.nome,
    required this.cidade,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      foto: json['foto'],
      nome: json['nome'],
      cidade: json['cidade'],
    );
  }
}

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Empresa> _empresas = [];

  @override
  void initState() {
    super.initState();
    _fetchEmpresas();
  }

  Future<void> _fetchEmpresas() async {
    var url = Uri.https("apicasadecor.com", "/api/empresas");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        var empresasData = jsonDecode(responseBody);

        setState(() {
          _empresas = List<Empresa>.from(empresasData.map((empresaJson) => Empresa.fromJson(empresaJson)));
        });

        // Adicione mensagens de depuração
        print('Empresas carregadas com sucesso.');
      } else {
        print('Failed to fetch empresas. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching empresas: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Empresas'),
      ),
      body: _empresas.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _empresas.length,
              itemBuilder: (context, index) {
                final empresa = _empresas[index];
               // final itemNumber = index + 1; // Número do item na lista

                return ListTile(
                  title: Text('${empresa.nome}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cidade: ${empresa.cidade}'),
                    ],
                  ),
                  leading: Image.network(empresa.foto),
                );
              },
            ),
    );
  }
}


