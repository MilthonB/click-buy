import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProduuctsHome extends StatelessWidget {
  SearchProduuctsHome({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ref.watch(searchProductsProvider);
    
    // return Text('asdas');
    return SizedBox(
      width: 1200,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Buscar productos...",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                  prefixIcon: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.black38,
                    size: 25,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ),

          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () {
              final String searchQuery = _controller.value.text;

              if (searchQuery == '') {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     backgroundColor: Colors.teal,
                //     content: Text(''),
                //     duration: Duration(seconds: 2),
                //   ),
                // );
                return;
              }
              // print(searchQuery);
              // ref
              //     .read(searchProductsProvider.notifier)
              //     .searchProduct(searchQuery);

              context.read<ProductsCubit>().searchProducts(searchQuery);
            },
            icon: Icon(Icons.search_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
