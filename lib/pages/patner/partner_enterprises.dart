import 'package:flutter/material.dart';
import 'package:nucleo/controllers/company_controller.dart';
import 'package:nucleo/kpadding.dart';
import 'package:nucleo/model/enterprise_item.dart';
import 'package:nucleo/pages/patner/item.dart';
import 'package:nucleo/responsive.dart';

class PartnerEnterprises extends StatefulWidget {
  const PartnerEnterprises({super.key});

  @override
  State<PartnerEnterprises> createState() => _PartnerEnterprisesState();
}

class _PartnerEnterprisesState extends State<PartnerEnterprises> {
  final CompanyController _controller = CompanyController();

  var selectedCountry = "Selecionar";

  @override
  void initState() {
    _controller.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context); // ✅ Removido kIsWeb
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              // ✅ Container de topo opcional removido
              StreamBuilder<List<EnterpriseItem>>(
                stream: _controller.userListController.stream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kPadding),
                            child: ResponsiveLayout(
                              forceIpadList: true,
                              iphone: snapshot.data!.isNotEmpty
                                  ? ListView(
                                      children: [
                                        for (var data in snapshot.data!)
                                          if (data.tipo == "EMPRESA")
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                              child: ItemPartner(
                                                photo: data.photo ?? "",
                                                name: data.name ?? "",
                                                city: data.city ?? "",
                                              ),
                                            )
                                      ],
                                    )
                                  : const Center(child: Text("Nenhum dado disponível")),
                              ipad: GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                                itemCount: snapshot.data!.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: kPadding,
                                  crossAxisSpacing: kPadding,
                                  childAspectRatio: 1.20,
                                ),
                                itemBuilder: (context, index) => ItemPartner(
                                  photo: snapshot.data![index].photo ?? "",
                                  name: snapshot.data![index].name ?? "",
                                  city: snapshot.data![index].city ?? "",
                                ),
                              ),
                              macbook: GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                                itemCount: snapshot.data!.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: kPadding,
                                  crossAxisSpacing: kPadding,
                                  childAspectRatio: 1.20,
                                ),
                                itemBuilder: (context, index) => ItemPartner(
                                  photo: snapshot.data![index].photo ?? "",
                                  name: snapshot.data![index].name ?? "",
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
