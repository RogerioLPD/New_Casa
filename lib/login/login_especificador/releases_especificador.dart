import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/components/blog.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/model/acquisitions_item.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';
import 'package:nucleo/utils/custom_text_styles.dart';

class ReleasesEspecificador extends StatefulWidget {
  ReleasesEspecificador({Key? key}) : super(key: key);

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
                    "Empresa".toUpperCase(),
                    style: CustomTextStyles.bold,
                  ),
                ),
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
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 380.0,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      snapshot.data![index].valor ?? "No data",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 350.0,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      snapshot.data![index].empresa!.name ??
                                          "No data",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : const CircularProgressIndicator();
              }),
        ],
      ),
    );
  }

  bodyForMobile() {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Container(
            padding: customPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Extrato".toUpperCase(),
                  style:const TextStyle(
                                              //color: Color.fromARGB(255, 10, 22, 88),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
                          final item = snapshot.data![index];
                          return Card(
                            elevation: 3,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  width: 70,
                                  padding: const EdgeInsets.only(
                                       top: 65, ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color.fromARGB(255, 10, 22, 88),
                                        size: 25,
                                      ),
                                      
                                       
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 150.0,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                       child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.empresa!.name ?? "No data",
                                            style: const TextStyle(
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                          
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: const <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(255, 10, 22, 88),
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(255, 10, 22, 88),
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(255, 10, 22, 88),
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(255, 10, 22, 88),
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(255, 10, 22, 88),
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                         
                                        ],
                                                                         ),
                                     ),
                                     const SizedBox(width: 50,),
                                   
                                       Container(
                                        constraints: const BoxConstraints(
                                          
                                          maxWidth: 100,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        
                                        child: Row(
                                          children:[
                                           Text(
                                            snapshot.data![index].valor ?? "No data",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          const Text(
                                             "Pts",
                                            style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ],
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        
                      
                    
                        
                    

                             /*Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                //borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                       maxWidth: 0.5,
                                      ),
                                      padding: const EdgeInsets.only(left:8),
                                      child: const Icon(Icons.arrow_right
                                        
                                      ),
                                    ),
                                    const SizedBox(width: 30,),
                                    Container(
                                      
                                      constraints: const BoxConstraints(
                                        maxWidth: 150.0,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        snapshot.data![index].empresa!.name ??
                                            "No data",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                     const SizedBox(width: 100,),
                                     Expanded(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 40.0,
                                          maxWidth: 600.0,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          snapshot.data![index].valor ?? "No data",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );*/
                          },
                        ),
                      )
                    : const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
