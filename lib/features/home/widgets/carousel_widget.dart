import 'package:carousel_slider/carousel_slider.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Globals.carouselImages
          .map((i) => Builder(
                builder: (context) {
                  return Image.network(
                    i,
                    fit: BoxFit.cover,
                    height: 200,
                  );
                },
              ))
          .toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }
}
