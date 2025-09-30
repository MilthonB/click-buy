import 'package:flutter/material.dart';

class ResponsiveGridView<T> extends StatelessWidget {
  final List<T> items;
  final double columnWidth;
  final double? mainAxisExtent; 
  final Widget Function(BuildContext, int) itemBuilder;
  const ResponsiveGridView({super.key, required this.items, required this.columnWidth, this.mainAxisExtent = 395, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // final double columnWidth = columWidth;
          final int crossAxisCount = (constraints.maxWidth/columnWidth).floor().clamp(2, 6);
          return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Desactiva el scroll interno
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: mainAxisExtent,
              ),
              itemBuilder: itemBuilder
            );  
        },
      ),
    );
  }
}
