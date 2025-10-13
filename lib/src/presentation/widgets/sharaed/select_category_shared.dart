import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCategoryShared extends StatelessWidget {
  const SelectCategoryShared({super.key});

  @override
  Widget build(BuildContext context) {
    // final selectedCategory = ref.watch(selectedCategoryProvider);
    // final selectedCategory = context.read<ProductsByCategory>().state;
    final selectedCategory = context.select<SelectedCategory, String>(
      (SelectedCategory value) => value.state,
    );

    final categories = [
      {"name": "all", "icon": Icons.select_all},
      {"name": "beauty", "icon": Icons.brush},
      {"name": "fragrances", "icon": Icons.spa},
      {"name": "furniture", "icon": Icons.chair},
      {"name": "groceries", "icon": Icons.local_grocery_store},
      {"name": "kitchen-accessories", "icon": Icons.kitchen},
    ];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category['name'] == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AnimatedContainer(
            
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.blue.shade400,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  // ref.read(selectedCategoryProvider.notifier).setCategory(category['name'].toString());
                  context.read<SelectedCategory>().setCategory(category['name'].toString());
            
                  // Cargamos productos según la categoría
                  if (category['name'] == "all") {
                    await context.read<ProductsCubit>().getProducts();
                  } else {
                    await context.read<ProductsCubit>().getProductsByCategory(category['name'].toString());
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: isSelected ? Colors.white : Colors.black54,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category['name'].toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
