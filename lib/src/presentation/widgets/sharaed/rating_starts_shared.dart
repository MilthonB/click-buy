import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        if (i < rating.floor()) return const Icon(Icons.star, color: Colors.amber, size: 18);
        if (i < rating) return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        return const Icon(Icons.star_border, color: Colors.amber, size: 18);
      }),
    );
  }
}