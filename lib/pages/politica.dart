import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// ignore: todo
// TODO Replace with object model.
const String listItemTitleText1 = "Política de Privacidade do aplicativo Núcleo Casa Decor";
const String listItemPreviewText1 = "Desenvolvedor: Rogério Luiz Pinheiro Dangui.";
const String listItemTitleText2 = "Público alvo do aplicativo";
const String listItemPreviewText2 = "Este aplicativo é destinado às empresa e profissionais da área de Arquitetura, Design de Interiores e decoração que fazem parte do programa de relacionamento e fidelidade do Núcleo Casa Decor.";
const String listItemTitleText = "Em suma";
const String listItemPreviewText ="Esta Declaração de Privacidade descreve os dados e recursos que coletamos para o aplicativo Núcleo Casa Decor, nos sistemas operacionais iOS e Android. O aplicativo inclui uma aplicação de software para os usuários fazerem o download para um dispositivo e um serviço que proporciona maior facilidade para usuários acompanharem o seu cadastro e os benefícios oferecidos pelo Núcleo Casa Decor. Estamos empenhados em proteger a sua privacidade e ressaltamos que as informações que forem coletadas no aplicativo tem como objetivo melhorar a sua experiência de usuário.";
const String listItemTitleText3 = "Anúncios";
const String listItemPreviewText3 = "Este aplicativo não possui anúncios de terceiros.";
const String listItemTitleText4 = "Acesso do aplicativo";
const String listItemPreviewText4 = "O aplicativo pode acessar sua identificação, informações de contato, localização, informações sobre o telefone, mídias, câmera e microfone. As utilizações desses recursos, em partes ou em sua totalidade, poderão ser feitas gradativamente nas versõs do aplicativo e/ou quando demandadas pelo público alvo do mesmo.Nós podemos coletar e processar outras informações, como seu nome, número de telefone e informações de suporte, para fornecer o serviço e realizar as transações que autorizar. Se você̂ encontrar problemas com o serviço, você̂ pode entrar em contato conosco para obter suporte técnico. Nós podemos coletar o desempenho do processo e informações de uso para fornecer e melhorar o aplicativo e outros produtos e serviços que nós, nossa controladora ou nossas afiliadas podem oferecer.";
const String listItemTitleText5 = "Divulgação de dados";
const String listItemPreviewText5 = "A Núcleo Casa Decor não faz venda ou arrendamento de dados dos usuários do aplicativo. Também não vamos compartilhar dados com terceiros fora da Núcleo Casa Decor e afiliadas, exceto nas seguintes circunstâncias estreitas: ● Se você solicitar ou autorizar a divulgação; ● Para proteger os direitos de propriedade de nossa companhia ou outros usuários, inclusive para evitar fraudes ou para fazer valer os nossos acordos ou políticas que regem o uso do serviço; ● Se vender ou reorganizar a totalidade ou parte do nosso negócio, poderemos ter de divulgar informações do usuário a um terceiro que adquira nossos ativos,conforme permitido por lei; ● Contrato com fornecedores para prestar serviços para como suporte ao cliente, e-mail marketing, e serviços de infraestrutura técnica. Podemos acessar, divulgar e preservar as suas informações pessoais quando acreditarmos que isso seja necessário para: ● Cumprir a legislação aplicável ou responder a processo legal válido de autoridades competentes, incluindo da aplicação da lei ou outras agências governamentais; ● Para evitar spam ou tentativas de fraudar usuários do aplicativo; ● Operar e manter a segurança do aplicativo, inclusive para prevenir ou parar um ataque em nossos sistemas de computadores ou redes, ou proteger os nossos direitos ou propriedade.";
const String listItemTitleText6 = "Exceções";
const String listItemPreviewText6 = "Não são considerados sigilosos os dados que já se encontrarem em domínio público; tenham sido revelados a terceiros que não tenham obrigação de privacidade; se tornem do conhecimento da Núcleo Casa Decor ou coligadas por outros meios, que não os aqui dispostos.";
const String listItemTitleText7 = "Segurança";
const String listItemPreviewText7 = "O aplicativo foi construído com a segurança dos dados como uma prioridade. Estamos comprometidos com a proteção de seus dados. Nós usamos protocolos de segurança interna padrão.";
const String listItemTitleText8 = "Excluindo os seus dados";
const String listItemPreviewText8 = "Você pode apagar os dados armazenados no serviço desinstalando o aplicativo do seu dispositivo.";
const String listItemTitleText9 = "Dados Localização";
const String listItemPreviewText9 = "As informações que coletamos e processo podem ser armazenadas e processadas no Brasil ou qualquer outro país em que nós ou nossa matriz, afiliados e provedores de serviços mantenham instalações. O aplicativo acessa a sua localização para que eles possam: ● Ajudar na navegação do usuário; ● Servir conteúdo relevante para o seu local. Importante: O aplicativo não compartilha sua localização.";
const String listItemTitleText10 = "Mudanças a esta Declaração de Privacidade";
const String listItemPreviewText10 = "Ocasionalmente, poderemos modificar e/ou rever nossa Política de Privacidade de tempos em tempos. Se fizermos quaisquer alterações de conteúdo nesta Declaração de Privacidade, não iremos notificá-lo, cabendo ao usuário acessar a página disponibilizada para tal finalidade.";
const String listItemTitleText11 = "Aplicabilidade";
const String listItemPreviewText11 = "Essa política de privacidade abrange os sistemas operacionais Android e IOS.";
const String listItemTitleText12 = "Como entrar em contato conosco";
const String listItemPreviewText12 = "Se você̂ tem uma dúvida sobre privacidade geral ou uma pergunta, entre em contato com a Núcleo Casa Decor por e-mail  abaixo: ● Por e-mail: nucleocasadecor@nucleocasadecor.com.br Para mais informações, consulte www.nucleocasadecor.com.br. Ponta Grossa-PR (Brasil), 05 de Outubro de 2023 ";

class PoliticPage extends StatefulWidget {
  const PoliticPage({Key? key}) : super(key: key);

  @override
  _PoliticPageState createState() => _PoliticPageState();
}

class _PoliticPageState extends State<PoliticPage> {
  
 
 

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
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/Nucleo.png',
                    width: 400,
                    height: 140,
                    fit: BoxFit.fill,
                  ),
                  divider,
                  const ListItem(
                      title: listItemTitleText1,
                      description: listItemPreviewText1),
                  divider,
                  const ListItem(
                      title: listItemTitleText,
                      description: listItemPreviewText),
                  divider,
                  const ListItem(
                      title: listItemTitleText2,
                      description: listItemPreviewText2),
                  divider,
                  const ListItem(
                      title: listItemTitleText3,
                      description: listItemPreviewText3),
                  divider,
                  const ListItem(
                      title: listItemTitleText4,
                      description: listItemPreviewText4),
                  divider,
                  const ListItem(
                      title: listItemTitleText5,
                      description: listItemPreviewText5),
                  divider,
                  const ListItem(
                      title: listItemTitleText6,
                      description: listItemPreviewText6),
                  divider,
                  const ListItem(
                      title: listItemTitleText7,
                      description: listItemPreviewText7),
                  divider,
                  const ListItem(
                      title: listItemTitleText8,
                      description: listItemPreviewText8),
                  divider,
                  const ListItem(
                      title: listItemTitleText9,
                      description: listItemPreviewText9),
                  divider,
                  const ListItem(
                      title: listItemTitleText10,
                      description: listItemPreviewText10),
                  divider,
                  const ListItem(
                      title: listItemTitleText11,
                      description: listItemPreviewText11),
                  divider,
                  const ListItem(
                      title: listItemTitleText12,
                      description: listItemPreviewText12),
                  divider,
                  
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


