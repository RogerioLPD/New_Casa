import 'package:flutter/material.dart';
import 'package:nucleo/controllers/specifier_controller.dart';
import 'package:nucleo/model/acquisitions_item.dart';

/// Author: Ambika Dulal
/// profile: https://github.com/ambikadulal

class HiddenDrawerNav extends StatefulWidget {
  static const String path = "lib/src/pages/navigation/hidden_drawer_nav.dart";

  const HiddenDrawerNav({super.key});
  @override
  _HiddenDrawerNavState createState() => _HiddenDrawerNavState();
}

class _HiddenDrawerNavState extends State<HiddenDrawerNav>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double? screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller1;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  final SpecifierController _controller = SpecifierController();
  final EdgeInsets customPadding = const EdgeInsets.fromLTRB(30, 0, 25, 0);


  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller1);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller1);
    _slideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(_controller1);
  }

  @override
  void dispose() {
    _controller.initValues();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        
         Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  
                  color: Color.fromARGB(255, 20, 1, 105),
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/Logo.png'),
                ),
              ],
            ),
          ),
          Expanded(
           child: Stack(
            children: <Widget>[
              menu(),
              dashboard(),
            ],
                 ),
         ),
        ],
      ),
    );
  }

  Widget menu() {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text("Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Messages",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Services",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Abouts Us",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Contact Us",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard() {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.2 * screenWidth!,
      right: isCollapsed ? 0 : -0.2 * screenWidth!,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Color.fromARGB(255, 7, 0, 99),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: const Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller1.forward();
                            } else {
                              _controller1.reverse();
                            }

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      const Text("My Cards",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      const Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container( // Novo Container para envolver o Expanded
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
                  /*SizedBox(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.redAccent,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.blueAccent,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.greenAccent,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text(
                            "Macbook",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            "Apple",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          trailing: Text(
                            "-36000",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 16);
                      },
                      itemCount: 5)*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}