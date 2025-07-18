import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String nome;
  final String tipo;
  final DateTime dateJoined;
  final String email;

  User({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.dateJoined,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      dateJoined: DateTime.parse(json['date_joined']),
      email: json['email'],
    );
  }
}

class UserListPage1 extends StatefulWidget {
  const UserListPage1({super.key});

  @override
  _UserListPage1State createState() => _UserListPage1State();
}



class _UserListPage1State extends State<UserListPage1> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      print('Token not available.');
      return;
    }

    var url = Uri.https("apicasadecor.com", "/api/usuario");
    Map<String, String> headers = {
      'Authorization': "Token $token",
      'content-type': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        var userData = jsonDecode(responseBody);

        var especificadorUsers = userData.where((userJson) => userJson['tipo'] == 'ESPECIFICADOR').toList();
        especificadorUsers.sort((a, b) => a['nome'].compareTo(b['nome']) as int); // Correção aqui

        setState(() {
          _users = List<User>.from(especificadorUsers.map((userJson) => User.fromJson(userJson)));
        });
      } else {
        print('Failed to fetch users.');
      }
    } catch (e) {
      print('Error fetching users: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      body: _users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                final itemNumber = index + 1; // Número do item na lista

                return ListTile(
                  title: Text('$itemNumber - ${user.nome}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email: ${user.email}'),
                      Text('Data de Registro: ${user.dateJoined}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
