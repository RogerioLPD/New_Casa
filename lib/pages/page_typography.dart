import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/pages/premios/item.dart';
import 'package:nucleo/pages/premios/viagem_item.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({Key? key}) : super(key: key);

  Color get primarySwatch => Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const MenuBar1(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Item(
                    item: products[index],
                    onPressed: () {},
                  ),
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
