import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              const MenuBar1(),
              const ImageWrapper(
                image: "assets/images/mugs_side_bw_w1080.jpg",
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: marginBottom12,
                  child: Text(
                    "A BETTER BLOG FOR WRITING",
                    style: headlineTextStyle,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextBodySecondary(text: "Writing  /  Project"),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextBody(
                    text:
                        "Apresentamos a nova empresa da Casa Decor Ltda., o Núcleo Casa Decor que é um programa de reconhecimento a profissionais da área de arquitetura, construção, decoração e design. O Núcleo Casa Decor é um Programa de Relacionamento entre lojas do Núcleo e profissionais da área de Decoração, que levará arquitetos, decoradores e designers de interiores para conhecer lugares incríveis pelo Brasil e pelo mundo, como incentivo á cultura, e conhecimento técnico através do circuito de compras entre as lojas do Núcleo, uma oportunidade única para vivenciar intensamente cada destino e de tornar a viagem uma experiência inspiradora. Além das viagens é realizado palestras, workshops, e outras ações, como forma de gerar aproximação entre empresas participantes e profissionais. O objetivo desse projeto é fortalecer o segmento de arquitetura, construção e decoração através da união das empresas do Núcleo com os especificados, e como fruto oferecer produtos e serviços cada vez melhores aos seus clientes através da intermediação dos profissionais que também fazem parte do Núcleo Casa Decor. "),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextBody(
                    text:
                        "Montes nascetur ridiculus mus mauris vitae ultricies leo. Vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra. Magna sit amet purus gravida. In dictum non consectetur a erat nam. Et egestas quis ipsum suspendisse ultrices. Tempor orci dapibus ultrices in iaculis nunc sed augue. Feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam. Feugiat nisl pretium fusce id velit ut tortor pretium."),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                    TextHeadlineSecondary(text: "Secondary Headline Example"),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextBody(
                    text:
                        "Nullam lobortis faucibus cursus. Sed aliquam semper mi sit amet interdum. Aliquam felis quam, ultrices ut elementum a, porta vel ex. Pellentesque at tempus magna. Vestibulum viverra lectus quis laoreet ullamcorper. Nunc finibus orci in luctus hendrerit. Ut dui mi, lacinia hendrerit elit ut, malesuada luctus enim."),
              ),
              const TextBlockquote(
                  text:
                      "Arcu ac tortor dignissim convallis aenean et tortor. Neque vitae tempus quam pellentesque nec nam aliquam. Dictum varius duis at consectetur lorem donec massa sapien faucibus. Etiam tempor orci eu lobortis elementum nibh tellus molestie nunc. Ac odio tempor orci dapibus ultrices in iaculis nunc sed."),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextBody(
                    text:
                        "Sed elementum tempus egestas sed sed risus. Mauris in aliquam sem fringilla ut morbi tincidunt. Placerat vestibulum lectus mauris ultrices eros. Et leo duis ut diam. Auctor neque vitae tempus quam. Nec nam aliquam sem et tortor consequat. Suspendisse interdum consectetur libero id faucibus nisl. Ornare suspendisse sed nisi lacus sed viverra. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Egestas purus viverra accumsan in nisl nisi."),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TagWrapper(tags: [
                  Tag(tag: "Writing"),
                  Tag(tag: "Photography"),
                  Tag(tag: "Development")
                ]),
              ),
              ...authorSection(
                  imageUrl: "assets/images/avatar_default.png",
                  name: "Type Pages",
                  bio:
                      "Mattis molestie a iaculis at erat pellentesque adipiscing commodo. Suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sed euismod nisi porta lorem. Aliquet nec ullamcorper sit amet risus nullam eget felis eget."),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: const PostNavigation(),
              ),
              divider,
              // Footer
              const Footer(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
