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
    return FutureBuilder<bool>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostrar um widget de carregamento enquanto aguarda os dados
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || !snapshot.data!) {
          // Caso ocorra algum erro ou o usuário não esteja logado como administrador
          // Redirecionar para a página de registro ou login para empresas
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 600,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Acesso Negado!',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 252, 4, 4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Espaço entre o texto e o botão
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.home);
                          },
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                              color: Color.fromARGB(255, 6, 2, 73),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ), // Cor do texto do botão
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else { 
          
    return Scaffold(
      // drawer: WillPopScope(
      //   onWillPop: () async {
      //     Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
      //     return true;
      //   },
      //   child: Drawer(
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: [
      //         const UserAccountsDrawerHeader(
      //           accountName: Text('user',
      //               style: TextStyle(
      //                 color: Colors.black54,
      //                 fontWeight: FontWeight.w500,
      //               )),
      //           accountEmail: Text('email',
      //               style: TextStyle(
      //                 color: Colors.black54,
      //                 fontWeight: FontWeight.w500,
      //               )),
      //         ),
      //         ListTile(
      //           dense: true,
      //           title: const Text('Sair'),
      //           trailing: const Icon(Icons.exit_to_app),
      //           onTap: () {},
      //         ),
      //         ListTile(
      //           dense: true,
      //           title: const Text('Search'),
      //           trailing: const Icon(Icons.search),
      //           onTap: () {},
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
      //   flexibleSpace: const Text('user',
      //       textAlign: TextAlign.right,
      //       style: TextStyle(
      //         color: Colors.black54,
      //         fontWeight: FontWeight.w500,
      //       )),
      //   title: const Text('name',
      //       style: TextStyle(
      //         color: Colors.black54,
      //         fontWeight: FontWeight.w500,
      //       )),
      //   centerTitle: true,
      // ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: MenuBar1(),
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                height: 150,
                child:
                    Image.asset("assets/images/Logo.png", fit: BoxFit.contain),
              ),
            ),
            // const Text(
            //   "Welcome Back",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Text('email',
            //     style: TextStyle(
            //       color: Colors.black54,
            //       fontWeight: FontWeight.w500,
            //     )),
            // const Text('name',
            //     style: TextStyle(
            //       color: Colors.black54,
            //       fontWeight: FontWeight.w500,
            //     )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.registerempresas),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black, // Set border color
                          width: 0.2), // Set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.0)), // Set rounded corner radius
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 0.1,
                            color: Colors.black,
                            offset: Offset(0.1, 1))
                      ], // Make rounded corner of border
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.domain_add,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Adicionar Empresa",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.cadastroespecificador),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black, // Set border color
                          width: 0.2), // Set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.0)), // Set rounded corner radius
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 0.1,
                            color: Colors.black,
                            offset: Offset(0.1, 1))
                      ], // Make rounded corner of border
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person_add,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Adicionar Especificador",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.cadastropremio),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black, // Set border color
                          width: 0.2), // Set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.0)), // Set rounded corner radius
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 0.1,
                            color: Colors.black,
                            offset: Offset(0.1, 1))
                      ], // Make rounded corner of border
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.post_add,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Adicionar Premio",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            ActionChip(
              label: const Text("Logout"),
              onPressed: () => {
                    _auth.doLogout(),
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (route) => false)
                  }),
          ],
        ),
      ),
    );
    
    
   
        }
      },
    );
  }
}
  

Future<bool> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      var url = Uri.parse('https://apicasadecor.com/api/usuario/1');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json', // Defina o Content-Type como application/json
        },
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        String userType = userData['seguimento'];
        print('seguimento $userType');
        return userType == 'Admin';
      }
    }

    return false;
  }
