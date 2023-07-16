import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import '../../models/product.dart';
import 'package:flutter/material.dart';

class DottedCarousel extends StatefulWidget {
  final List<File>? imagesPath;
  final List<String>? images;
  final bool isDotRequired;
  const DottedCarousel(
      {super.key, this.images, this.imagesPath, this.isDotRequired = true});

  @override
  State<DottedCarousel> createState() => _DottedCarouselState();
}

class _DottedCarouselState extends State<DottedCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.images != null
                ? widget.images!
                    .map((i) => Builder(
                          builder: (context) {
                            return Image.network(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            );
                          },
                        ))
                    .toList()
                : widget.imagesPath!
                    .map((i) => Builder(
                          builder: (context) {
                            return Image.file(
                              i,
                              fit: BoxFit.contain,
                              height: 200,
                            );
                          },
                        ))
                    .toList(),
            options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        const SizedBox(height: 5),
        widget.isDotRequired
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images != null
                    ? widget.images!.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList()
                    : widget.imagesPath!.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
