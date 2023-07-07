import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/kpadding.dart';
import 'package:nucleo/routes.dart';

class MenuSide extends StatefulWidget {
  const MenuSide({
    Key? key,
    this.selected = false,
  }) : super(key: key);
  final bool selected;

  @override
  State<MenuSide> createState() => _MenuSideState();
}

class _MenuSideState extends State<MenuSide> {
  DateTime selectedDate = DateTime.now();

  get selected => false;

  Color get primarySwatch => Colors.grey;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: <Widget>[
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName)),
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
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName)),
                        style: menuButtonStyle,
                        child: const Text(
                          "HOME",
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.checagempage),
                        style: menuButtonStyle,
                        child: const Text(
                          "LOGIN EMPRESAS",
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.loginespecificador),
                        style: menuButtonStyle,
                        child: const Text(
                          "LOGIN ESPECIFICADOR",
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.loginadministrador),
                        style: menuButtonStyle,
                        child: const Text(
                          "LOGIN ADM.",
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.premios),
                        style: menuButtonStyle,
                        child: const Text(
                          "PRÊMIOS",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: kIsWeb ? kPadding : 0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                height: 60,
                child: Text(
                  'Extrato de Pontos',
                  style: headlineTextStyle,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                height: 250,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 45,
                    ),
                    Text('Inicio:', style: bodyTextStyle),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _selectDate(context),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.hovered) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.white.withOpacity(0.8);
                              }

                              return primarySwatch;
                            }),
                            textStyle:
                                MaterialStateProperty.resolveWith<TextStyle>(
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
                          ),
                          icon: const Icon(Icons.date_range_outlined,
                              color: Color(0xFF3A3A3A)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child:
                              Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text('Fim:', style: bodyTextStyle),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _selectDate(context),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.hovered) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.white.withOpacity(0.8);
                              }

                              return primarySwatch;
                            }),
                            textStyle:
                                MaterialStateProperty.resolveWith<TextStyle>(
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
                          ),
                          icon: const Icon(Icons.date_range_outlined,
                              color: Color(0xFF3A3A3A)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child:
                              Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(130, 0, 130, 0),
                      child: OutlinedButton(
                        onPressed: () {},
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
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.hovered) ||
                                states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }

                            return primarySwatch;
                          }),
                          textStyle:
                              MaterialStateProperty.resolveWith<TextStyle>(
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
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16)),
                        ),
                        child: const Text(
                          "Buscar",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Total',
                      style: headlineTextStyle,
                    ),
                    Text(
                      '0',
                      style: headlineTextStyle,
                    ),
                    Text(
                      'Pts',
                      style: headlineSecondaryTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
