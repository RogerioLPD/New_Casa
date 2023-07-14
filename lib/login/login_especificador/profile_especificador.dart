import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/model/user_details.dart';
import 'package:nucleo/responsive.dart';

class ProfileEspecificador extends StatefulWidget {
  ProfileEspecificador({super.key});

  @override
  State<ProfileEspecificador> createState() => _ProfileEspecificadorState();
}

class _ProfileEspecificadorState extends State<ProfileEspecificador> {
  final SpecifierController _controller = SpecifierController();

  @override
  void initState() {
    _controller.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
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
              preferredSize: const Size.fromHeight(0), child: Container()),
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
                         subtitle: profileItem(snapshot.data!.segment, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("Tipo", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.type, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("CPF", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cpf, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.badge_rounded, color: Colors.grey, size: 26),
                         title: const Text("CNPJ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cnpj, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.phone, color: Colors.grey, size: 26),
                         title: const Text("Telefone", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.phone, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.phone_iphone, color: Colors.grey, size: 26),
                         title: const Text("Celular", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cellPhone, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Endereço", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.address, const TextStyle(fontSize: 16)),
                         
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Bairro", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.district, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Cidade", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.city, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("Estado", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.state, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                        ListTile(
                        leading: const Icon(Icons.home_work, color: Colors.grey, size: 26),
                         title: const Text("CEP", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                         subtitle: profileItem(snapshot.data!.cep, const TextStyle(fontSize: 16)),
                         ),
                        const Divider(),
                      ],
                    ),
                  )
                
              
              
            
                
              
            
          
            
            
              /* const SizedBox(
                height: 12,
              ),
            
            profileItem(snapshot.data!.nome, const TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Segmento:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.segment, const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text("Tipo:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.type, const TextStyle(fontSize: 18)),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("CPF:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.cpf, const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text("CNPJ:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.cnpj, const TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Telefone:", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                profileItem(snapshot.data!.phone, const TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Celular:", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                profileItem(
                    snapshot.data!.cellPhone, const TextStyle(fontSize: 18)),
              ],
            ),
            profileItem(snapshot.data!.address, const TextStyle(fontSize: 18)),
            profileItem(snapshot.data!.number, const TextStyle(fontSize: 18)),
            profileItem(snapshot.data!.district, const TextStyle(fontSize: 18)),
            profileItem(snapshot.data!.city, const TextStyle(fontSize: 18)),
            profileItem(snapshot.data!.state, const TextStyle(fontSize: 18)),
            profileItem(snapshot.data!.cep, const TextStyle(fontSize: 18)),*/
          ],
        ),
                
              ),
            
          ]
        )
      )
    );
  }

  bodyForWeb(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 250),
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            // Container(
            //   child: CachedNetworkImage(
            //       height: 120,
            //       imageUrl: "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg"
            //   ),
            // )
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  //child: Icon(Icons.account_circle_outlined, size: 150,),
                  child: CachedNetworkImage(
                    height: 150,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80)),
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
            const SizedBox(
              height: 12,
            ),
            profileItem(snapshot.data!.nome, const TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("Segmento:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.segment, const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text("Tipo:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.type, const TextStyle(fontSize: 18)),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("CPF:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.cpf, const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text("CNPJ:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.cnpj, const TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Telefone:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                profileItem(
                    snapshot.data!.phone, const TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Celular:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                profileItem(
                    snapshot.data!.cellPhone, const TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("Rua:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.address, const TextStyle(fontSize: 18))
                  ],
                ),
                Row(
                  children: [
                    const Text("Número:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.number, const TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("CEP:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.cep, const TextStyle(fontSize: 18))
                  ],
                ),
                Row(
                  children: [
                    const Text("Bairro:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.district, const TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("Cidade:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.city, const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text("Estado:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    profileItem(
                        snapshot.data!.state, const TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  profileItem(String? data, TextStyle style) {
    return Text(
      data ?? "Não informado",
      style: style,
    );
  }
}
