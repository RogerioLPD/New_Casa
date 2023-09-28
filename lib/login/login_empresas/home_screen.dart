import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/routes.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';


class HomeEmpresas extends StatelessWidget {
   final AuthenticationController _auth = AuthenticationController();
   HomeEmpresas({Key? key}) : super(key: key);

  Color get primarySwatch => Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route<dynamic> route) => false);
          return true;
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: <Widget>[
                    const MenuBar1(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("LANÇAMENTO DE VENDAS",
                            style: headlineTextStyle),
                      ),
                    ),
                    Container(
                      margin: marginBottom60,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Nome do Estabelecimento",
                            style: headlineTextStyle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom24,
                        child: TextFormField(
                          style: subtitleTextStyle,
                          decoration: const InputDecoration(
                            hintText: 'Digite o nome do estabelecimento',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: marginBottom24,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Especificador", style: headlineTextStyle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom24,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormatter()
                          ],
                          style: subtitleTextStyle,
                          decoration: const InputDecoration(
                            hintText: 'Digite o CPF ou CNPJ',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: marginBottom24,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Valor Total das Vendas",
                            style: headlineTextStyle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom24,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RealInputFormatter()
                          ],
                          style: subtitleTextStyle,
                          decoration: const InputDecoration(
                            hintText:
                                'Digite o valor total das vendas para gerar a pontuação',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(textPrimary),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return const BorderSide(color: textPrimary, width: 2);
                          }

                          return BorderSide(color: primarySwatch, width: 2);
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.white;
                          }

                          return primarySwatch;
                        }),
                        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                            (states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            );
                          }

                          return GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: textPrimary,
                                letterSpacing: 1),
                          );
                        }),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16)),
                      ),
                      child: const Text(
                        "GERAR",
                      ),
                    ),
                    Container(
                      margin: marginBottom40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Valor Total de Pontos",
                            style: headlineTextStyle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom24,
                        child: Text("1980", style: headlineTextStyle),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(textPrimary),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return const BorderSide(color: textPrimary, width: 2);
                          }

                          return BorderSide(color: primarySwatch, width: 2);
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.white;
                          }

                          return primarySwatch;
                        }),
                        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                            (states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            );
                          }

                          return GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: textPrimary,
                                letterSpacing: 1),
                          );
                        }),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16)),
                      ),
                      child: const Text(
                        "LANÇAR",
                      ),
                    ),
                    Container(
                      margin: marginBottom100,
                    ),
                    divider,
                     Align(
                  alignment: Alignment.bottomRight,
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
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
