import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/productos_slideshow.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/products_home.dart';
import 'package:clickbuy/src/presentation/screens/home/widgets/search_products_home.dart';
import 'package:clickbuy/src/presentation/widgets/sharaed/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // final heightMax =  MediaQuery.sizeOf(context).height;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // print("Cargar más productos");
        // final position = _scrollController.position.pixels;
        context.read<ProductsCubit>().loadMoreProducts();

        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (_scrollController.hasClients) {
        //     _scrollController.jumpTo(position);
        //   }
        // });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cargar carrito
    final user = context.read<AuthCubit>().getUser();
    if (user != null) {
      context.read<CartCubit>().loadCart(user.id);
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
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
