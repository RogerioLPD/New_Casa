import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/controllers/authenticator_controller.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/login/login_especificador/profile_especificador.dart';
import 'package:nucleo/login/login_especificador/releases_especificador.dart';
import 'package:nucleo/pages/patner/partner_enterprises.dart';
import 'package:nucleo/pages/premios/premios.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';

class HomeEspecificador extends StatefulWidget {
  HomeEspecificador({super.key});

  @override
  State<HomeEspecificador> createState() => _HomeEspecificadorState();
}

class _HomeEspecificadorState extends State<HomeEspecificador> {
  final SpecifierController _controller = SpecifierController();
  final AuthenticationController _auth = AuthenticationController();
  bool isHomeSelected = false;
  bool isPointsSelected = false;
  bool isRewardsSelected = false;
  bool isEnterprisesSelected = false;
  bool isProfileSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      iphone: pageViewForMobile(context),
      ipad: bodyForWeb(context),
      macbook: bodyForWeb(context),
    );
  }

  pageViewForMobile(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller.pageController,
        children: [
          bodyForMobile(context),
          ReleasesEspecificador(),
          RewardsPage(),
          PartnerEnterprises(),
          ProfileEspecificador()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                    tooltip: "Menu",
                    iconSize: 40,
                    isSelected: isHomeSelected,
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      _controller.initValues();
                      _controller.pageController.jumpToPage(0);
                      setState(() {
                        isHomeSelected = true;
                        isPointsSelected = false;
                        isRewardsSelected = false;
                        isEnterprisesSelected = false;
                        isProfileSelected = false;
                      });
                    },
                  ),
                  const Text("Home")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    isSelected: isPointsSelected,
                    tooltip: "Pontuação",
                    icon: const Icon(Icons.receipt_long_outlined),
                    onPressed: () {
                      setState(() {
                        isHomeSelected = false;
                        isPointsSelected = true;
                        isRewardsSelected = false;
                        isEnterprisesSelected = false;
                        isProfileSelected = false;
                      });
                      _controller.pageController.jumpToPage(1);
                    },
                  ),
                  const Text("Pontuação")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    tooltip: "Prêmios",
                    isSelected: isRewardsSelected,
                    icon: const Icon(Icons.card_giftcard),
                    onPressed: () {
                      setState(() {
                        isHomeSelected = false;
                        isPointsSelected = false;
                        isRewardsSelected = true;
                        isEnterprisesSelected = false;
                        isProfileSelected = false;
                      });
                      _controller.pageController.jumpToPage(2);
                    },
                  ),
                  const Text("Prêmios")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    tooltip: "Empresas",
                    isSelected: isEnterprisesSelected,
                    icon: const Icon(Icons.domain),
                    onPressed: () {
                      setState(() {
                        isHomeSelected = false;
                        isPointsSelected = false;
                        isRewardsSelected = false;
                        isEnterprisesSelected = true;
                        isProfileSelected = false;
                      });
                      _controller.pageController.jumpToPage(3);
                    },
                  ),
                  const Text("Empresas")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 40,
                    tooltip: "Perfil",
                    icon: const Icon(Icons.account_circle_outlined),
                    isSelected: isProfileSelected,
                    onPressed: () {
                      setState(() {
                        isHomeSelected = false;
                        isPointsSelected = false;
                        isRewardsSelected = false;
                        isEnterprisesSelected = false;
                        isProfileSelected = true;
                      });
                      _controller.pageController.jumpToPage(4);
                    },
                  ),
                  const Text("Perfil")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bodyForMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: 250,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Saldo de Pontos",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    StreamBuilder<int>(
                        stream: _controller.pointsController.stream,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: Text(
                                        snapshot.data!.toString(),
                                        style: const TextStyle(
                                          fontSize: 100,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      alignment: Alignment.bottomCenter,
                                      child: const Text(
                                        "Pts",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(
                                  height: 120,
                                  child: Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator())),
                                );
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.extrato),
                            child: Text(
                              "EXTRATO",
                              style: TextStyle(color: Colors.lightBlue[900]),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                ),
                children: [
                  menuItem(
                    context,
                    Icons.receipt_long_outlined,
                    "Pontuação",
                    () {
                      if (kIsWeb) {
                        Navigator.pushNamed(context, Routes.extrato);
                      } else {
                        setState(() {
                          isHomeSelected = false;
                          isPointsSelected = true;
                          isRewardsSelected = false;
                          isEnterprisesSelected = false;
                          isProfileSelected = false;
                        });
                        _controller.pageController.jumpToPage(1);
                      }
                    },
                  ),
                  menuItem(
                    context,
                    Icons.domain,
                    "Empresas",
                    () {
                      if (kIsWeb) {
                        Navigator.pushNamed(context, Routes.empresas);
                      } else {
                        setState(() {
                          isHomeSelected = false;
                          isPointsSelected = false;
                          isRewardsSelected = false;
                          isEnterprisesSelected = true;
                          isProfileSelected = false;
                        });
                        _controller.pageController.jumpToPage(3);
                      }
                    },
                  ),
                  menuItem(
                    context,
                    Icons.card_giftcard,
                    "Premios",
                    () {
                      if (kIsWeb) {
                        Navigator.pushNamed(context, Routes.extrato);
                      } else {
                        setState(() {
                          isHomeSelected = false;
                          isPointsSelected = false;
                          isRewardsSelected = true;
                          isEnterprisesSelected = false;
                          isProfileSelected = false;
                        });
                        _controller.pageController.jumpToPage(2);
                      }
                    },
                  ),
                  menuItem(
                    context,
                    Icons.account_circle_outlined,
                    "Perfil",
                    () {
                      if (kIsWeb) {
                        Navigator.pushNamed(context, Routes.extrato);
                      } else {
                        setState(() {
                          isHomeSelected = false;
                          isPointsSelected = false;
                          isRewardsSelected = false;
                          isEnterprisesSelected = false;
                          isProfileSelected = true;
                        });
                        _controller.pageController.jumpToPage(4);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          ActionChip(
              label: const Text("Logout"),
              onPressed: () {
                _auth.doLogout();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.loginespecificador, (route) => false);
              }),
        ],
      ),
    );
  }

  bodyForWeb(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
           
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: 250,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Saldo de Pontos",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<int>(
                            stream: _controller.pointsController.stream,
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      height: 120,
                                      child: Text(
                                        snapshot.data!.toString(),
                                        style: const TextStyle(
                                          fontSize: 100,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  : const CircularProgressIndicator();
                            }),
                        Container(
                          height: 100,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            "Pts",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (kIsWeb) {
                                Navigator.pushNamed(context, Routes.extrato);
                              } else {
                                _controller.pageController.jumpToPage(1);
                              }
                            },
                            child: Text(
                              "EXTRATO",
                              style: TextStyle(color: Colors.lightBlue[900]),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // const Text(
          //   "Welcome Back",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // const Text('email',
          //     style: TextStyle(
          //       color: Colors.black54,
          //       fontWeight: FontWeight.w500,
          //     )),
          // const Text('name',
          //     style: TextStyle(
          //       color: Colors.black54,
          //       fontWeight: FontWeight.w500,
          //     )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                ),
                children: [
                  menuItem(
                    context,
                    Icons.receipt_long_outlined,
                    "Pontuação",
                    () => Navigator.pushNamed(context, Routes.extrato),
                  ),
                  menuItem(
                    context,
                    Icons.domain,
                    "Empresas",
                    () => Navigator.pushNamed(context, Routes.empresas),
                  ),
                  menuItem(
                    context,
                    Icons.card_giftcard,
                    "Premios",
                    () => {},
                  ),
                  menuItem(
                    context,
                    Icons.account_circle_outlined,
                    "Perfil",
                    () => Navigator.pushNamed(
                      context,
                      Routes.profile,
                    ),
                  )
                ],
              ),
            ),
          ),
          ActionChip(
              label: const Text("Logout"),
              onPressed: () => {
                    _auth.doLogout(),
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (route) => false)
                  }),
        ],
      ),
    );
  }

  menuItem(BuildContext context, IconData icon, String title,
      VoidCallback function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: const BoxDecoration(
          //color: Colors.white,
          // border: Border.all(
          //     color: Colors.black, // Set border color
          //     width: 0.2), // Set border width
          borderRadius: BorderRadius.all(
              Radius.circular(5.0)), // Set rounded corner radius
          // boxShadow: const [
          //   BoxShadow(
          //       blurRadius: 0.1, color: Colors.black, offset: Offset(0.1, 1))
          // ], // Make rounded corner of border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Icon(
                color: Colors.blueGrey[800],
                icon,
                size: 70,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
