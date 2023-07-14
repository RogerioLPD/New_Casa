import 'package:flutter/material.dart';
import 'package:nucleo/kpadding.dart';
import 'package:nucleo/pages/premios/viagem_item.dart';

class Item extends StatelessWidget {
  final ProductItem item;
  final Function onPressed;
  final bool selected;

  Item({
    Key? key,
    required this.item,
    required this.onPressed,
    this.selected = false,
  }) : super(key: key);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(kPadding),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).primaryColor
                    : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
              child: Hero(
                tag: "${item.uid}",
                child: Container(
                  width: double.infinity,
                  height: 220,
                  child: Image.network(
                    item.image_1!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kPadding / 2,
            ),
            Text(
              "${item.amount}  Pontos",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPadding / 4),
              child: Text(
                item.title!,
                style:
                    TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: kPadding / 4),
              child: Text(
                item.description!,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            const SizedBox(
              height: kPadding / 2,
            ),
          ],
        ),
      ),
    );
  }
}
