import 'package:carousel_slider/carousel_slider.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((imageUrl) {
        return Builder(
          builder: (context) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInOutCubic,
        scrollPhysics: const ClampingScrollPhysics(),
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        viewportFraction: 1,
        height: mq.width * .3,
      ),
    );
  }
}
