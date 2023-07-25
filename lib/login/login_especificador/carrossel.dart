import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ImageCarousel extends StatelessWidget {
  final List<String> imageAssetPaths;

  ImageCarousel({required this.imageAssetPaths});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: imageAssetPaths.map((assetPath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              
              width: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}