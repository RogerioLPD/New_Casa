import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/components/blog.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/model/acquisitions_item.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';
import 'package:nucleo/utils/custom_text_styles.dart';

class ReleasesEspecificador extends StatefulWidget {
  ReleasesEspecificador({super.key});

  @override
  State<ReleasesEspecificador> createState() => _ReleasesEspecificadorState();
}

class _ReleasesEspecificadorState extends State<ReleasesEspecificador> {
  final SpecifierController _controller = SpecifierController();

  final EdgeInsets customPadding = const EdgeInsets.fromLTRB(30, 0, 25, 0);

  @override
  void initState() {
    _controller.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      macbook: bodyForWeb(),
      ipad: bodyForWeb(),
      iphone: bodyForMobile(),
    );
  }

  bodyForWeb() {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: const MenuBar1(),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: customPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 380.0,
                  ),
                  child: Text(
                    "Valor".toUpperCase(),
                    style: CustomTextStyles.bold,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 350.0,
                  ),
                  child: Text(
                    "Nome".toUpperCase(),
                    style: CustomTextStyles.bold,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 350.0,
                  ),
                  child: Text(
                    "Empresa".toUpperCase(),
                    style: CustomTextStyles.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<AcquisitionsItem>>(
              stream: _controller.detailsController.stream,
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                            padding: customPadding,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 380.0,
                                      ),
                                      child: Text(snapshot.data![index].valor ??
                                          "No data")),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 350.0,
                                    ),
                                    child: Text(
                                      snapshot.data![index].empresa!.firstName ??
                                          "No data",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  //Text(snapshot.data![index].empresa!.firstName ?? "No data",textAlign: TextAlign.right),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 350.0,
                                    ),
                                    child: Text(
                                        snapshot.data![index].empresa!.type ??
                                            "No data"),
                                  )
                                ],
                              );
                            }),
                      )
                    : const CircularProgressIndicator();
              })
        ],
      ),
    );
  }

  bodyForMobile() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              padding: customPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Valor".toUpperCase(), style: CustomTextStyles.bold),
                  Text("Nome".toUpperCase(), style: CustomTextStyles.bold),
                  Text("Empresa".toUpperCase(), style: CustomTextStyles.bold),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<AcquisitionsItem>>(
                stream: _controller.detailsController.stream,
                builder: (_, snapshot) {
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                              padding: customPadding,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 40.0,
                                          maxWidth: 600.0,
                                        ),
                                        child: Text(
                                            snapshot.data![index].valor ??
                                                "No data")),
                                    Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 40.0,
                                          maxWidth: 600.0,
                                        ),
                                        child: Text(
                                            snapshot.data![index].empresa!
                                                    .firstName ??
                                                "No data",
                                            textAlign: TextAlign.right)),
                                    //Text(snapshot.data![index].empresa!.firstName ?? "No data",textAlign: TextAlign.right),
                                    Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 40.0,
                                      ),
                                      child: Text(
                                          snapshot.data![index].empresa!.type ??
                                              "No data"),
                                    )
                                  ],
                                );
                              }),
                        )
                      : const CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}