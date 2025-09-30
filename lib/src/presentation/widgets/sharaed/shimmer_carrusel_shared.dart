


import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCarruselShared extends StatelessWidget {
  const ShimmerCarruselShared({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: 1200,
          height: 210,
          child: Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            itemCount: 3,
            autoplay: false,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
        );
  }
}