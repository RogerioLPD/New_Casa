import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nucleo/components/blog.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:nucleo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeAdministrador extends StatefulWidget {
  const HomeAdministrador({Key? key}) : super(key: key);

  @override
  State<HomeAdministrador> createState() => _HomeAdministradorState();
}

class _HomeAdministradorState extends State<HomeAdministrador> {
  final AuthenticationController _auth = AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: MenuBar1(),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                height: 150,
                child: Image.asset("assets/images/Logo.png", fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Adicionar Empresa
                _buildOption(
                  icon: Icons.domain_add,
                  label: "Adicionar Empresa",
                  route: Routes.registerempresas,
                ),
                // Adicionar Especificador
                _buildOption(
                  icon: Icons.person_add,
                  label: "Adicionar Especificador",
                  route: Routes.cadastroespecificador,
                ),
                // Adicionar Prêmio
                _buildOption(
                  icon: Icons.post_add,
                  label: "Adicionar Prêmio",
                  route: Routes.cadastropremio,
                ),
              ],
            ),
            const SizedBox(height: 80),
            ActionChip(
              label: const Text("Logout"),
              onPressed: () {
                _auth.doLogout();
                Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({required IconData icon, required String label, required String route}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.1,
              color: Colors.black,
              offset: Offset(0.1, 1),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
