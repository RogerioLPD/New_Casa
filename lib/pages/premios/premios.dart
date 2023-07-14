import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/controllers/rewards_controller.dart';
import 'package:nucleo/kpadding.dart';
import 'package:nucleo/pages/premios/item.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';

class RewardsPage extends StatefulWidget {
  RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  Color get primarySwatch => Colors.grey;
  final RewardsController rewardsController = RewardsController();

  @override
  void initState() {
    rewardsController.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: kIsWeb ? const Size.fromHeight(150) : Size.zero,
        child: kIsWeb ? const MenuBar1() : Container(),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (kIsWeb) {
            Navigator.pop(context);
          }
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              StreamBuilder<List>(
                  stream: rewardsController.dataController.stream,
                  builder: (context, snapshot) {
                    List sortedList = snapshot.data!;
                    sortedList.sort((a, b) => b.amount.compareTo(a.amount)); // Ordena a lista com base no atributo 'pontos'

                    return snapshot.hasData
                        ? snapshot.data!.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: Text("Sem Premios no momento")))
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  child: ResponsiveLayout(
                                    forceIpadList: true,
                                    iphone: GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding),
                                      itemCount: sortedList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: kPadding * 2, // Increase main axis spacing
                                        crossAxisSpacing: kPadding * 2,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder: (context, index) => Item(
                                        selected:
                                            ResponsiveLayout.isIphone(context)
                                                ? false
                                                : index == 0,
                                        item: sortedList[index],
                                        onPressed: () {},
                                      ),
                                    ),
                                    ipad: GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding),
                                      itemCount: sortedList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: kPadding,
                                        crossAxisSpacing: kPadding,
                                        childAspectRatio: 1.20,
                                      ),
                                      itemBuilder: (context, index) => Item(
                                        selected:
                                            ResponsiveLayout.isIphone(context)
                                                ? false
                                                : index == 0,
                                        item: sortedList[index],
                                        onPressed: () {},
                                      ),
                                    ),
                                    macbook: GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding),
                                      itemCount: sortedList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: kPadding,
                                        crossAxisSpacing: kPadding,
                                        childAspectRatio: 1.20,
                                      ),
                                      itemBuilder: (context, index) => Item(
                                        selected:
                                            ResponsiveLayout.isIphone(context)
                                                ? false
                                                : index == 0,
                                        item: sortedList[index],
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              )
                        : const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(child: CircularProgressIndicator()),
                          );
                  }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
