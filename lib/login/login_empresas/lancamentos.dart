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
  final AuthenticationController _auth = AuthenticationController();
  final ReleasesController _controller = ReleasesController();

  final valorVendasController = TextEditingController();
  final StreamController<String> valorPontosController = StreamController.broadcast();
  final nomeEstabelecimentoController = TextEditingController();
  final especificadorController = TextEditingController();

  String valorPontosControllerText = "";
  String especificadorNome = '';

  @override
  void dispose() {
    valorVendasController.dispose();
    nomeEstabelecimentoController.dispose();
    especificadorController.dispose();
    valorPontosController.close();
    super.dispose();
  }

  void calcularPontos() {
    // Faz parsing considerando moeda BR, depois calcula os pontos
    final valorVendas = NumberFormat.currency(locale: 'pt_BR').parse(valorVendasController.text).toDouble();
    final valorPontos = valorVendas / 1000;

    // Formata para 2 casas decimais, usa ponto como separador decimal
    final valorPontosFormatado = valorPontos.toStringAsFixed(2).replaceAll(',', '.');

    valorPontosController.sink.add(valorPontosFormatado);
    valorPontosControllerText = valorPontosFormatado;
    especificadorNome = especificadorController.text;
  }

  ButtonStyle gerarButtonStyle() {
    const Color textPrimary = Color(0xFF3A3A3A);
    const Color primarySwatch = Colors.grey;
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all<Color>(textPrimary),
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed)) {
          return const BorderSide(color: textPrimary, width: 2);
        }
        return BorderSide(color: primarySwatch, width: 2);
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed)) {
          return Colors.white;
        }
        return primarySwatch;
      }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed)) {
          return GoogleFonts.montserrat(
            textStyle: const TextStyle(fontSize: 14, color: Colors.white, letterSpacing: 1),
          );
        }
        return GoogleFonts.montserrat(
          textStyle: const TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1),
        );
      }),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
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
                        child: Text("LANÇAMENTO DE VENDAS", style: headlineTextStyle),
                      ),
                    ),
                    Container(margin: marginBottom60),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Nome do Estabelecimento", style: headlineTextStyle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom24,
                        child: TextFormField(
                          controller: nomeEstabelecimentoController,
                          keyboardType: TextInputType.text,
                          style: subtitleTextStyle,
                          decoration: const InputDecoration(
                            hintText: 'Digite o nome do estabelecimento',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormatter()
                          ],
                          style: subtitleTextStyle,
                          decoration: const InputDecoration(
                            hintText: 'Digite o CPF ou CNPJ',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Valor Total das Vendas", style: headlineTextStyle),
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
                            hintText: 'Digite o valor total das vendas para gerar a pontuação',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),

                    OutlinedButton(
                      onPressed: calcularPontos,
                      style: gerarButtonStyle(),
                      child: const Text("GERAR"),
                    ),
                    Container(margin: marginBottom40),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text("Valor Total de Pontos", style: headlineTextStyle),
                      ),
                    ),
                    StreamBuilder<String>(
                      stream: valorPontosController.stream,
                      builder: (context, snapshot) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: marginBottom24,
                            child: Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: headlineTextStyle,
                            ),
                          ),
                        );
                      },
                    ),

                    OutlinedButton(
                      onPressed: () async {
                        bool response = await _controller.doRelease(
                          valor: valorPontosControllerText,
                          empresa: nomeEstabelecimentoController.text,
                          doc: especificadorController.text,
                        );

                        if (response) {
                          Navigator.pushReplacementNamed(context, Routes.lancamentos);
                          setState(() {
                            especificadorNome = especificadorController.text;
                          });

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Sucesso'),
                              content: Text('Lançamento feito com sucesso para: $especificadorNome'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao fazer lançamento')),
                          );
                        }
                      },
                      style: gerarButtonStyle(),
                      child: const Text("LANÇAR"),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        elevation: 0,
                        onPressed: () {
                          _auth.doLogout();
                          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
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

                    Container(margin: marginBottom100),
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
  }
}
