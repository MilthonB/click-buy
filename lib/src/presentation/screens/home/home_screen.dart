import 'package:card_swiper/card_swiper.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/categories_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/productos_slideshow.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/products_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/search_products_home.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/appbar_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/secction_title_shared.dart';
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
                // CategoriesHome(),
                // PaginatedCategoriesHome(
                //   categories: List.generate(24, (index) => 'Categoria $index'),
                // ),

                // SecctionTitleShared(nameSection: 'Productos', seeMore: 'Mirar mas'),
                ProductsHome(),
                // ProductosSlideshow(),
              ],
            );
            // Text('data');
          }, childCount: 1),
        ),
      ],
    );
  }
}
