
import 'package:clickbuy/src/presentation/screens/home/widgets/products_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/search_products_home.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/appbar_shared.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/select_category_shared.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.white,
            ),
            titlePadding: const EdgeInsets.all(0),
            title: AppbarShared(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                SearchProduuctsHome(),
                SelectCategoryShared(),
                ProductsHome()
              ],
            );
            // Text('data');
          },childCount: 1)
        )
      ],
    );
  }
}