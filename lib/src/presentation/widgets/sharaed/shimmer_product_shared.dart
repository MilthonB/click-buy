

import 'package:clickbuy/src/presentation/widgets/sharaed/responsive_grid_view_shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductShared extends StatelessWidget {
  const ShimmerProductShared({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ResponsiveGridView(
            items: List.generate(4, (_) => null), // 4 placeholders
            columnWidth: 200,
            mainAxisExtent: 430,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen simulada
                        Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        // Título simulado
                        Container(height: 16, width: 100, color: Colors.white),
                        const SizedBox(height: 4),
                        // Descripción simulada
                        Container(
                          height: 14,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        // Precio y descuento simulados
                        Container(height: 14, width: 80, color: Colors.white),
                        const SizedBox(height: 8),
                        // Botones simulados
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }
}