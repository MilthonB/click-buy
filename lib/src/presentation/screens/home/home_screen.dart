
import 'package:clickbuy/src/presentation/screens/home/widgets/productos_slideshow.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/products_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/search_products_home.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/appbar_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/select_category_shared.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(color: Colors.white),
            titlePadding: const EdgeInsets.all(0),
            title: AppbarShared(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                SearchProduuctsHome(),
                ProductosSlideshow(),
                SelectCategoryShared(),
                ProductsHome(),
              ],
            );
            // Text('data');
          }, childCount: 1),
        ),
      ],
    );
  }
}
