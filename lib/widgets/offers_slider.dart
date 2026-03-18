import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> offerImages = ['assets/offer1.png', 'assets/offer2.png'];

    return CarouselSlider.builder(
      itemCount: offerImages.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(offerImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true, // every 3 seconds will move
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true, // the current photo become bigger than others
        viewportFraction: 0.83, // width of screen
        aspectRatio: 16 / 9, // ratio length : width
        autoPlayCurve: Curves.fastOutSlowIn, // move fast , then slow
      ),
    );
  }
}
