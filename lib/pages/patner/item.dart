import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/kpadding.dart';

class ItemPartner extends StatelessWidget {
  final String? photo;
  final String name;
  final String? description;
  final String city;

  ItemPartner({
    Key? key,
    required this.photo,
    required this.name,
    required this.description,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: kPadding, right: 80),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: photo != ""
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Hero(
                      tag: "$photo",
                      child: CachedNetworkImage(
                        height: 300,
                        width: 450,
                        imageUrl: photo!,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kPadding / 4),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 20,
              ),
            ),
          ),
           Container( // Container adicionado para envolver a descrição
            padding: const EdgeInsets.symmetric(vertical: kPadding / 4, ), // Ajuste as margens conforme necessário
            child: Text(
              description ?? "",
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Text(
            city,
            style: TextStyle(color: Colors.black.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
