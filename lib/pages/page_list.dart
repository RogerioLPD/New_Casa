import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// ignore: todo
// TODO Replace with object model.
const String listItemTitleText1 = "COMO FUNCIONA?";
const String listItemPreviewText1 = "";
const String listItemTitleText2 = "SUGESTÃO DE VIAGENS";
const String listItemPreviewText2 = "";
const String listItemTitleText = "SOBRE NÓS";
const String listItemPreviewText =
    "Apresentamos a nova empresa da Casa Decor Ltda., o Núcleo Casa Decor que é um programa de reconhecimento a profissionais da área de arquitetura, construção, decoração e design. O Núcleo Casa Decor é um Programa de Relacionamento entre lojas do Núcleo e profissionais da área de Decoração, que levará arquitetos, decoradores e designers de interiores para conhecer lugares incríveis pelo Brasil e pelo mundo, como incentivo á cultura, e conhecimento técnico através do circuito de compras entre as lojas do Núcleo, uma oportunidade única para vivenciar intensamente cada destino e de tornar a viagem uma experiência inspiradora. Além das viagens é realizado palestras, workshops, e outras ações, como forma de gerar aproximação entre empresas participantes e profissionais. O objetivo desse projeto é fortalecer o segmento de arquitetura, construção e decoração através da união das empresas do Núcleo com os especificados, e como fruto oferecer produtos e serviços cada vez melhores aos seus clientes através da intermediação dos profissionais que também fazem parte do Núcleo Casa Decor.";

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  
 
  @override
  void initState() {
    super.initState();
    // Aguarda o fim do initState e, em seguida, exibe o Popout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopout(context);
    });
  }

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
                    'assets/images/Logo.png',
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
                    'assets/images/home.jpg',
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
void _showPopout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
            width: 400,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Ajuste esse valor para arredondar as bordas
          ),
         /* title:  AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          WavyAnimatedText('NÚCLEO CASA DECOR'),
          
        ],
        onTap: () {
          print("Tap Event");
        },
          ),*/
          content: SizedBox(
            height:300,
            width: 400, // Ajuste esse valor para definir a largura do content do AlertDialog
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          WavyAnimatedText('BAIXE AGORA O APLICATIVO!', textStyle: GoogleFonts.montserrat(
                          color: textPrimary,
                          fontSize: 18,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w500),textAlign: TextAlign.center),
          
        ],
        onTap: () {
          print("Tap Event");
        },
          ),
          const SizedBox(height: 40),
                 Text('Se você é um profissional das áreas de Arquitetura e Decoração baixe agora o app faça o seu cadastro e comece a pontuar!',style:GoogleFonts.montserrat(
                          color: textPrimary,
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal) ,
                          textAlign: TextAlign.justify,),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchURL('https://apps.apple.com/br/app/nucleo-casadecor/id6450630598');
                      },
                      child: Image.asset(
                        'assets/images/apple.png',
                        width: 140,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        _launchURL('https://play.google.com/store/apps/details?id=com.nucleo.casadecor');
                      },
                      child: Image.asset(
                        'assets/images/generic.png',
                        width: 140,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          /*actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],*/
        ),
      );
    },
  );
}



void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o URL: $url';
    }
  }



