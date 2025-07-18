import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/color.dart';
import 'package:nucleo/components/spacing.dart';
import 'package:nucleo/components/text.dart';
import 'package:nucleo/components/typography.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:nucleo/routes.dart';
import 'package:url_launcher/url_launcher.dart';
class ImageWrapper extends StatelessWidget {
  final String image;

  const ImageWrapper({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    //TODO Listen to inherited widget width updates.
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image,
        width: width,
        height: width / 1.618,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TagWrapper extends StatelessWidget {
  final List<Tag> tags;

  const TagWrapper({Key? key, this.tags = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: paddingBottom24,
        child: Wrap(
          spacing: 8,
          runSpacing: 0,
          children: <Widget>[...tags],
        ));
  }
}

class Tag extends StatelessWidget {
  final String tag;

  const Tag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      fillColor: const Color(0xFF242424),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      hoverElevation: 0,
      hoverColor: const Color(0xFFC7C7C7),
      highlightElevation: 0,
      focusElevation: 0,
      child: Text(
        tag,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReadMoreButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.pushNamed(context, Routes.premios),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(textPrimary),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return const BorderSide(color: textPrimary, width: 2);
          }

          return const BorderSide(color: textPrimary, width: 2);
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return Colors.white;
          }

          return textPrimary;
        }),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 14, color: Colors.white, letterSpacing: 1),
            );
          }

          return GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 14, color: textPrimary, letterSpacing: 1),
          );
        }),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
      ),
      child: const Text(
        "Ver Prêmios",
      ),
    );
  }
}

const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);
Widget dividerSmall = Container(
  width: 40,
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA0A0A0),
        width: 1,
      ),
    ),
  ),
);

List<Widget> authorSection({String? imageUrl, String? name, String? bio}) {
  return [
    divider,
    Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: <Widget>[
          if (imageUrl != null)
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (name != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextHeadlineSecondary(text: name),
                  ),
                if (bio != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bio,
                      style: bodyTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    divider,
  ];
}

class PostNavigation extends StatelessWidget {
  const PostNavigation({Key? key}) : super(key: key);

  // ignore: todo
  // TODO Get PostID from Global Routing Singleton.
  // Example: String currentPage = RouteController.of(context).currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text("PREVIOUS POST", style: buttonTextStyle),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Text("NEXT POST", style: buttonTextStyle),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class ListNavigation extends StatelessWidget {
  const ListNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text("NEWER POSTS", style: buttonTextStyle),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Text("OLDER POSTS", style: buttonTextStyle),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  // ignore: todo
  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Align(
        alignment: Alignment.centerRight,
        child: TextBody(
            text:
                "© Todos os direitos reservados. Desenvolvido por Rogério L.P. Dangui ComCode ©2022"),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  // ignore: todo
  // TODO replace with Post item model.
  final String title;
  final String? imageUrl;
  final String? description;

  const ListItem(
      {Key? key, required this.title, this.imageUrl, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (imageUrl != null)
          ImageWrapper(
            image: imageUrl!,
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description!,
                style: bodyTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Container(
        //     margin: marginBottom24,
        //     child: ReadMoreButton(
        //       onPressed: () => Navigator.pushNamed(context, Routes.post),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Menu/Navigation Bar
 *
 * A top menu bar with a text or image logo and
 * navigation links. Navigation links collapse into
 * a hamburger menu on screens smaller than 400px.
 */
class MenuBar2 extends StatefulWidget {
  const MenuBar2({super.key});

  @override
  State<MenuBar2> createState() => MenuBar2State();
}

class MenuBar2State extends State<MenuBar2> {
  MenuBar2State({Key? key});

  AuthenticationController auth = AuthenticationController();
  bool authcheck = false;
  late GlobalKey dropdownKey;

  @override
  void initState() {
    dropdownKey = GlobalKey();
    initChecks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return menuSite(context);
  }

  initChecks() async {
    authcheck = await auth.checkAuthentication();
  }

  menuSite(BuildContext context) {
    rebuild();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: <Widget>[
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => {
                  if (ModalRoute.of(context)!.settings.name != '/')
                    {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.home, (Route<dynamic> route) => false)
                    }
                },
                child: Text("CASA DECOR",
                    style: GoogleFonts.montserrat(
                        color: textPrimary,
                        fontSize: 28,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500)),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: menuBody(true),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 30),
            color: const Color(0xFFEEEEEE)),
      ],
    );
  }

  menuBody(bool isAuth) {
    return [
      TextButton(
        onPressed: () => {
          if (ModalRoute.of(context)!.settings.name != '/')
            {Navigator.pushNamed(context, Routes.home)}
        },
        style: menuButtonStyle,
        child: const Text(
          "HOME",
        ),
      ),
    
      TextButton(
        onPressed: () {Navigator.pushNamed(context, Routes.premios);},
        style: menuButtonStyle,
        child: const Text(
          "Prêmios",
        ),
      ),
      TextButton(
        onPressed: () {Navigator.pushNamed(context, Routes.empresas);},
        style: menuButtonStyle,
        child: const Text(
          "Empresas",
        ),
      ),
      TextButton(
       onPressed: () {
                auth.doLogout();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.loginespecificador, (route) => false);
              },
        style: menuButtonStyle,
        child: const Text(
          "Logout",
        ),
      ),
      TextButton(
       onPressed: () {Navigator.pushNamed(context, Routes.profile);},
        style: menuButtonStyle,
        child: const Text(
          "Perfil",
        ),
      ),
      
    ];
  }

  routeManager() {}

  menuMobile(BuildContext context) {
    rebuild();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 45, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName)),
            child: Text(
              "CASA DECOR",
              style: GoogleFonts.montserrat(
                color: textPrimary,
                fontSize: 15,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: auth.loginCheckLoading.stream,
              builder: (context, snapshot) {
                return DropdownButton(
                  key: dropdownKey,
                  icon: const Icon(Icons.menu),
                  disabledHint: Container(),
                  underline: Container(),
                  items: menuBody(snapshot.data ?? true)
                      .map<DropdownMenuItem<Widget>>((Widget value) {
                    return DropdownMenuItem(
                      value: value,
                      child: value,
                    );
                  }).toList(),
                  onChanged: (value) {},
                );
              })
        ],
      ),
    );
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }
}
Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }


  class MenuBar1 extends StatefulWidget {
  const MenuBar1({super.key});

  @override
  State<MenuBar1> createState() => MenuBar1State();
}

class MenuBar1State extends State<MenuBar1> with SingleTickerProviderStateMixin {
  bool authcheck = false;
  late AnimationController _animationController;
  late Animation<Offset> _drawerSlideAnimation;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

 

 @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _openDrawer() {
    _controller.forward();
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => SlideTransition(
        position: _slideAnimation,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: ListView(
              children: _buildMenuItems(),
            ),
          ),
        ),
      ),
    ).then((_) {
      _controller.reverse();
    });
  }

  List<Widget> _buildMenuItems() {
    return [
      _menuButton("HOME", () {}),
      _menuButton("BLOG", () {}),
      _menuButton("REVISTA", () => _launchURL('https://revistacasadecor.com.br')),
      _menuButton("EQUIPE", () {}),
      _menuButton("CIDADES", () {}),
      _menuButton("AÇÕES", () {}),
      _menuButton("CONTATO", () {}),
      _menuButton("LOGIN",  () {
          if (ModalRoute.of(context)!.settings.name != Routes.loginadministrador) {
            Navigator.pushReplacementNamed(context, Routes.loginadministrador);
          }
          //Navigator.pop(dropdownKey.currentContext!);
        },),
    ];
  }

  Widget _menuButton(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 950;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/') {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  }
                },
                child: Text(
                  "CASA DECOR",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: isMobile ? 20 : 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                ),
              ),
              if (!isMobile)
                Row(children: _buildMenuItems())
              else
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: _openDrawer,
                ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }

  void _launchURL(String url) {
    // Aqui você pode usar o `url_launcher` se quiser abrir links
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}