import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_searchbox/modal_searchbox.dart';
import 'package:nucleo/components/blog.dart';
import 'package:nucleo/controllers/enterprise_controller.dart';
import 'package:nucleo/kpadding.dart';
import 'package:nucleo/model/enterprise_item.dart';
import 'package:nucleo/pages/patner/item.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';

class PartnerEnterprises extends StatefulWidget {
  PartnerEnterprises({super.key});

  @override
  State<PartnerEnterprises> createState() => _PartnerEnterprisesState();
}

class _PartnerEnterprisesState extends State<PartnerEnterprises> {
  final EnterpriseController _controller = EnterpriseController();

  var selectedCountry = "Selecionar";

  @override
  void initState() {
    _controller.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
              kIsWeb
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      //child: const MenuBar1(),
                    )
                  : Container(),
              StreamBuilder<List<String>>(
                stream: _controller.cityController.stream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          child: ModalSearchbox(
                              padding: const EdgeInsets.all(0),
                              showLabel: false,
                              label: "",
                              addSearch: true,
                              selectedValue: selectedCountry,
                              list: snapshot.data!,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              onChanged: (v) {
                                _controller.makeSearchBox(v);
                              }),
                        )
                      : Container();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<List<EnterpriseItem>>(
                  stream: _controller.dataController.stream,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: ResponsiveLayout(
                                forceIpadList: true,
                                // iphone: GridView.builder(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: kPadding),
                                //   itemCount: snapshot.data!.length,
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisCount: 1,
                                //     mainAxisSpacing: kPadding,
                                //     crossAxisSpacing: kPadding,
                                //     childAspectRatio: 1,
                                //   ),
                                //   itemBuilder: (context, index) => Item(
                                //     photo: snapshot.data![index].photo ?? "",
                                //     name: snapshot.data![index].name ?? "",
                                //     city: snapshot.data![index].city ?? "",
                                //   ),
                                // ),
                                iphone: snapshot.data!.isNotEmpty
                                    ? ListView(
                                        children: [
                                          for (var data in snapshot.data!)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                              child: ItemPartner(
                                                photo: data.photo ?? "",
                                                name: data.name ?? "",
                                                description:
                                                    data.description ?? "",
                                                city: data.city ?? "",
                                              ),
                                            )
                                        ],
                                      )
                                    : const Text("No data"),
                                ipad: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: kPadding,
                                    crossAxisSpacing: kPadding,
                                    childAspectRatio: 1.20,
                                  ),
                                  itemBuilder: (context, index) => ItemPartner(
                                    photo: snapshot.data![index].photo ?? "",
                                    name: snapshot.data![index].name ?? "",
                                    description:
                                        snapshot.data![index].description ?? "",
                                    city: snapshot.data![index].city ?? "",
                                  ),
                                ),
                                macbook: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: kPadding,
                                    crossAxisSpacing: kPadding,
                                    childAspectRatio: 1.20,
                                  ),
                                  itemBuilder: (context, index) => ItemPartner(
                                    photo: snapshot.data![index].photo ?? "",
                                    name: snapshot.data![index].name ?? "",
                                    description:
                                        snapshot.data![index].description ?? "",
                                    city: snapshot.data![index].city ?? "",
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 250),
                            child: CircularProgressIndicator(),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
