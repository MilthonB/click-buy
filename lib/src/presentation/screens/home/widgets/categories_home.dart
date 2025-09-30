import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaginatedCategoriesHome extends StatefulWidget {
  final List<String> categories;
  const PaginatedCategoriesHome({super.key, required this.categories});

  @override
  State<PaginatedCategoriesHome> createState() => _PaginatedCategoriesHomeState();
}

class _PaginatedCategoriesHomeState extends State<PaginatedCategoriesHome> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final itemsPerPage = 8;
    final pages = [
      for (var i = 0; i < widget.categories.length; i += itemsPerPage)
        widget.categories.sublist(
          i,
          (i + itemsPerPage) > widget.categories.length
              ? widget.categories.length
              : i + itemsPerPage,
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: pages.map((pageItems) {
                return Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: pageItems.map((cat) {
                      final index = widget.categories.indexOf(cat);
                      return SizedBox(
                        width: 70,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 70,
                              height: 70,
                            ),
                            Text('Categoria: $index'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _pageController,
            count: pages.length,
            effect: WormEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
