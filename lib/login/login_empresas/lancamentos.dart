import 'dart:async';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:nucleo/controllers/releases_controller.dart';
import 'package:nucleo/routes.dart';

class HomeEmpresas extends StatefulWidget {
  const HomeEmpresas({Key? key}) : super(key: key);

  @override
  State<HomeEmpresas> createState() => _HomeEmpresasState();
}

class _HomeEmpresasState extends State<HomeEmpresas> {
  Color get primarySwatch => Colors.grey;
  final ReleasesController _controller = ReleasesController();
  final valorVendasController = TextEditingController();
  final StreamController valorPontosController = StreamController.broadcast();
  final nomeEstabelecimentoController = TextEditingController();
  final especificadorController = TextEditingController();
  String valorPontosControllerText = "";
  final AuthenticationController _authController = AuthenticationController();

  @override
  void dispose() {
    valorVendasController.dispose();
    nomeEstabelecimentoController.dispose();
    especificadorController.dispose();
    super.dispose();
  }

  void calcularPontos() {
  final valorVendas = NumberFormat.currency(locale: 'pt_BR').parse(valorVendasController.text).toDouble();
  final valorPontos = valorVendas / 1000;
  final valorPontosFormatado = NumberFormat.compact(locale: 'pt_BR').format(valorPontos);

  // Substitua a vírgula por ponto
  final valorPontosFormatadoPonto = valorPontosFormatado.replaceAll(',', '.');

  valorPontosController.sink.add(valorPontosFormatadoPonto);
  valorPontosControllerText = valorPontosFormatadoPonto;
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _authController.loginCheckLoading.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route<dynamic> route) => false);
          return true;
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: <Widget>[
                    
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
                          //controller: nomeEstabelecimentoController,
                          keyboardType: TextInputType.text,
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
                          controller: especificadorController,
                          keyboardType: TextInputType.number,
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
                          controller: valorVendasController,
                          keyboardType: TextInputType.number,
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
                      onPressed:
                          calcularPontos, // Chama a função para calcular os pontos
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(textPrimary),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return const BorderSide(
                                color: textPrimary, width: 2);
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
                    StreamBuilder(
                        stream: valorPontosController.stream,
                        builder: (context, snapshot) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: marginBottom24,
                                child: Text(
                                  snapshot.hasData
                                      ? snapshot.data.toString()
                                      : "0",style: headlineTextStyle,
                                )),
                          );
                        }),
                    OutlinedButton(
                      onPressed: () async {
                        var text1 =
                            especificadorController.text.replaceAll(".", "");
                        var text2 = text1.replaceAll("-", "");
                        bool response = await _controller.doRelease(
                            valor: valorPontosControllerText,
                            empresa: nomeEstabelecimentoController.text,
                            doc: especificadorController.text);

                        if (response) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, Routes.lancamentos);
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Erro ao fazer login')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(textPrimary),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.pressed)) {
                            return const BorderSide(
                                color: textPrimary, width: 2);
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
     } else {
      
      return Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.registerempresas);
        },
        child: Text('Registrar como empresa'),
      ),
    ),
  );
    }
  },
);
  }
}