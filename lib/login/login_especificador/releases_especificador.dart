import 'package:flutter/material.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/model/acquisitions_item.dart';
import 'package:nucleo/responsive.dart';

class ReleasesEspecificador extends StatefulWidget {
  const ReleasesEspecificador({Key? key}) : super(key: key);

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
                style: const TextStyle(
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
        Expanded(
          child: Container( // Novo Container para envolver o Expanded
            alignment: Alignment.bottomCenter, // Alinhamento no final da Row
            child: StreamBuilder<List<AcquisitionsItem>>(
              stream: _controller.detailsController.stream,
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
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
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                    top: 65,
                                  ),
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
                                          maxWidth: 500.0,
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
                                      const SizedBox(
                                        width: 300,
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data![index].valor ?? "No data",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
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
                        },
                      )
                    : const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    ),
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
