import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/login/login_especificador/update_especificador.dart';
import 'package:nucleo/model/user_details.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';
import 'package:nucleo/controllers/administrator_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ProfileEspecificador extends StatefulWidget {
  const ProfileEspecificador({super.key});

  @override
  State<ProfileEspecificador> createState() => _ProfileEspecificadorState();
}

class _ProfileEspecificadorState extends State<ProfileEspecificador> {
  final SpecifierController _controller = SpecifierController();
  final AuthenticationController _auth = AuthenticationController();
  final AdministradorController _administradorController = AdministradorController();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  @override
  void initState() {
    _controller.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: kIsWeb
          ? PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(0), child: Container()),*/
      body: StreamBuilder<UserDetails>(
          stream: _controller.userController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ResponsiveLayout(
                    ipad: bodyForWeb(context, snapshot),
                    iphone: bodyForMobile(context, snapshot),
                    macbook: bodyForWeb(context, snapshot))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  bodyForMobile(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView( 
        child: Stack(
          
          children: <Widget>[
           // Row(
             // mainAxisAlignment: MainAxisAlignment.center,
              //children: [
                SizedBox(
                   height: 450,
                   width: double.infinity,
                  //child: Icon(Icons.account_circle_outlined, size: 150,),
                  child: CachedNetworkImage(
                    
                    fit: BoxFit.cover,
                    imageUrl: snapshot.data!.photo,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.account_circle_outlined,
                      size: 150,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                       // borderRadius: const BorderRadius.all(Radius.circular(80)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),  
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 300.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(234, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  profileItem(snapshot.data!.nome, TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blueGrey[800])),
                                  const SizedBox(height: 10.0),
                                  profileItem(
                        snapshot.data!.type, const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                 
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            /*Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: const <Widget>[
                                      Text(""),
                                      Text("")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: const <Widget>[
                                      Text(""),
                                      Text("")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: const <Widget>[
                                      Text(""),
                                      Text("")
                                    ],
                                  ),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                        
                      
                      Container(
                        height: 100,
                        width: 100,
                        /*decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.cover)),*/
                        margin: const EdgeInsets.only(left: 8.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                    imageUrl: snapshot.data!.photo,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.account_circle_outlined,
                      size: 150,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                        ),
                      ),
                    ],
                  ),
      
                  
              
              
            
            const SizedBox(height: 20.0),
                  Container(
                    
                    decoration: BoxDecoration(
                      color:const Color.fromARGB(234, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children:  <Widget>[
                        const ListTile(
                          title: Text("Informações Pessoais"),
                        ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.account_balance_wallet, color: Colors.grey, size: 26),
                         title: const Text("Segmento", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.segment ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("Tipo", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.type ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("CPF", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cpf ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                       
                        ListTile(
                        leading: const Icon(Icons.phone, color: Colors.grey, size: 26),
                         title: const Text("Telefone", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.phone ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.phone_iphone, color: Colors.grey, size: 26),
                         title: const Text("Celular", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cellPhone ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Endereço", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.address ?? '', const TextStyle(fontSize: 16)),
                         
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Bairro", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.district ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Cidade", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.city ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Estado", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.state ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        
                    const SizedBox(
                  height: 40,
                ),
                    Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () {
      // Navegue para a página de atualização aqui
      // Por exemplo, você pode usar a função Navigator.push para navegar para a página UpdateEspecificador
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateEspecificador()));
                      },
                    child: Text(
                      'EDITAR DADOS',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                       Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () => {
                            _auth.doLogout(),
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginespecificador, (route) => false)
                               },
                    child: Text(
                      'LOGOUT',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () async {
                     int? loggedUserId = snapshot.data!.id;
                       
                       if (loggedUserId != null) {
                      bool isDeleted = await _administradorController.deleteUsuario(loggedUserId);
                      if (isDeleted) {
                      showToast("Usuário excluído com sucesso!");
                       _auth.doLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginespecificador, (route) => false);
      // Adicione aqui qualquer outra lógica que você deseja executar após a exclusão do usuário.
                     } else {
                     showToast("Usuário excluído com sucesso!");
                    _auth.doLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginespecificador, (route) => false);
                     }
                     } else {
                         showToast("ID do usuário logado não encontrado.");
                       }
                   },

                    child: Text(
                      'EXCLUIR CONTA',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 252, 25, 25),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                       Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.homeespecificador),
                    child: Text(
                      'VOLTAR',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(
                  height: 40,
                ),
                      ],
                    ),
                  )
               
          ],
        ),
                
              ),
            
          ]
        )
      )
    );
  }

bodyForWeb(BuildContext context, AsyncSnapshot snapshot) {
  // Verifica se alguma das propriedades é nula
  bool dataIsNull = snapshot.data == null ||
      snapshot.data!.photo == null ||
      snapshot.data!.segment == null ||
      snapshot.data!.type == null ||
      snapshot.data!.cpf == null ||
      snapshot.data!.cnpj == null ||
      snapshot.data!.phone == null ||
      snapshot.data!.cellPhone == null ||
      snapshot.data!.address == null ||
      snapshot.data!.district == null ||
      snapshot.data!.city == null ||
      snapshot.data!.state == null ||
      snapshot.data!.cep == null;

  return Scaffold(
    appBar: AppBar(automaticallyImplyLeading: false),
    backgroundColor: Colors.grey.shade300,
    body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 1000,
            width: double.infinity,
            child: dataIsNull // Se alguma das propriedades for nula, mostra o botão de atualização
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Aqui, você pode fazer a chamada para atualizar os dados
                        // Pode ser uma função assíncrona para buscar os dados novamente
                        // E depois atualizar a exibição
                        // Por exemplo:
                        // _fetchDataAgain();
                      },
                      child: const Text('Atualizar Dados'),
                    ),
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: snapshot.data!.photo ?? '',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.account_circle_outlined, size: 150),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 500.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(top: 16.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(234, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 600,
                            margin: const EdgeInsets.only(left: 100.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                profileItem(snapshot.data!.nome, TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blueGrey[800])),
                                const SizedBox(height: 10.0),
                                profileItem(
                                  snapshot.data!.type, const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(left: 8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: snapshot.data!.photo,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.account_circle_outlined, size: 150),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      
                  
              
              
            
            const SizedBox(height: 20.0),
                  Container(
                    
                    decoration: BoxDecoration(
                      color:const Color.fromARGB(234, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children:  <Widget>[
                        const ListTile(
                          title: Text("Informações Pessoais"),
                        ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.account_balance_wallet, color: Colors.grey, size: 26),
                         title: const Text("Segmento", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.segment ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("Tipo", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.type ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("CPF", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cpf ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                       
                        ListTile(
                        leading: const Icon(Icons.phone, color: Colors.grey, size: 26),
                         title: const Text("Telefone", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.phone ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.phone_iphone, color: Colors.grey, size: 26),
                         title: const Text("Celular", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cellPhone ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Endereço", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.address ?? '', const TextStyle(fontSize: 16)),
                         
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Bairro", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.district ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Cidade", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.city ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Estado", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.state ?? '', const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        
                    const SizedBox(
                  height: 40,
                ),
                    Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () {
      // Navegue para a página de atualização aqui
      // Por exemplo, você pode usar a função Navigator.push para navegar para a página UpdateEspecificador
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateEspecificador()));
                      },
                    child: Text(
                      'EDITAR DADOS',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                       Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () => {
                            _auth.doLogout(),
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.home, (route) => false)
                               },
                    child: Text(
                      'LOGOUT',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () async {
                     int? loggedUserId = snapshot.data!.id;
                       
                       if (loggedUserId != null) {
                      bool isDeleted = await _administradorController.deleteUsuario(loggedUserId);
                      if (isDeleted) {
                      showToast("Usuário excluído com sucesso!");
                       _auth.doLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginespecificador, (route) => false);
      // Adicione aqui qualquer outra lógica que você deseja executar após a exclusão do usuário.
                     } else {
                     showToast("Usuário excluído com sucesso!");
                     _auth.doLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginespecificador, (route) => false);
                     }
                     } else {
                         showToast("ID do usuário logado não encontrado.");
                       }
                   },

                    child: Text(
                      'EXCLUIR CONTA',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 252, 25, 25),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                       Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.homeespecificador),
                    child: Text(
                      'VOLTAR',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(
                  height: 40,
                ),
                      ],
                    ),
                  )
               
          ],
        ),
                
              ),
            
          ]
        )
      )
    );
  }

  profileItem(String? data, TextStyle style) {
    return Text(
      data ?? "Não informado",
      style: style,
    );
  }
}
