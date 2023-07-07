import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/routes.dart';

// ignore: todo
// TODO Replace with object model.
const String listItemTitleText1 = "COMO FUNCIONA?";
const String listItemPreviewText1 = "";
const String listItemTitleText2 = "SUGESTÃO DE VIAGENS";
const String listItemPreviewText2 = "";
const String listItemTitleText = "SOBRE NÓS";
const String listItemPreviewText =
    "Apresentamos a nova empresa da Casa Decor Ltda., o Núcleo Casa Decor que é um programa de reconhecimento a profissionais da área de arquitetura, construção, decoração e design. O Núcleo Casa Decor é um Programa de Relacionamento entre lojas do Núcleo e profissionais da área de Decoração, que levará arquitetos, decoradores e designers de interiores para conhecer lugares incríveis pelo Brasil e pelo mundo, como incentivo á cultura, e conhecimento técnico através do circuito de compras entre as lojas do Núcleo, uma oportunidade única para vivenciar intensamente cada destino e de tornar a viagem uma experiência inspiradora. Além das viagens é realizado palestras, workshops, e outras ações, como forma de gerar aproximação entre empresas participantes e profissionais. O objetivo desse projeto é fortalecer o segmento de arquitetura, construção e decoração através da união das empresas do Núcleo com os especificados, e como fruto oferecer produtos e serviços cada vez melhores aos seus clientes através da intermediação dos profissionais que também fazem parte do Núcleo Casa Decor.";

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  const MenuBar1(),
                  Image.asset(
                    'assets/images/Nucleo.png',
                    width: 400,
                    height: 140,
                    fit: BoxFit.fill,
                  ),
                  divider,
                  Image.asset(
                    'assets/images/peoples.png',
                    width: double.infinity,
                    height: 370,
                    fit: BoxFit.cover,
                  ),
                  divider,
                  const ListItem(
                      title: listItemTitleText,
                      description: listItemPreviewText),
                  divider,
                  Image.asset(
                    'assets/images/home.png',
                    width: double.infinity,
                    height: 600,
                    fit: BoxFit.contain,
                  ),
                  /*const ListItem(
                      imageUrl: "assets/images/function.jpg",
                      title: listItemTitleText1,
                      description: listItemPreviewText1),*/
                  divider,
                  /*const ListItem(
                      imageUrl: "assets/images/home.png",
                      title: listItemTitleText2,
                      description: listItemPreviewText2),
                  divider,
                   Container(
                     padding: const EdgeInsets.symmetric(vertical: 80),
                    child:   ReadMoreButton(onPressed: () => Navigator.pushNamed(context, Routes.premios),),
                  ),*/
                  divider,
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
