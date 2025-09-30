import 'package:clickbuy/src/config/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavigation({super.key, required this.navigationShell});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    // pageController = PageController(initialPage: 0, keepPage: true);
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if( pageController.hasClients ){
    //   pageController.animateToPage(widget.navigationShell.currentIndex, duration: Duration(milliseconds: 250), curve: Curves.easeOutBack);
    // }

    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        // controller: ,
        // controller: pageController,
        children: [widget.navigationShell],
        // children: [
        //   HomeHistoryView(),
        //   VeterinariansView(),
        //   AllNecessitiesView(),
        // ],
      ),
      bottomNavigationBar: _CustomBottomNavigation(
        navigationShell: widget.navigationShell,
      ),
    );
  }
}

class _CustomBottomNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const _CustomBottomNavigation({required this.navigationShell});

  @override
  State<_CustomBottomNavigation> createState() =>
      _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<_CustomBottomNavigation> {
  void _goBranch(int index) {
    if (!_rootInitials(context, widget.navigationShell.currentIndex, index))
      widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // key: ,
      currentIndex: widget.navigationShell.currentIndex,
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      // backgroundColor: Colors.black,
      // useLegacyColorScheme: false,
      // selectedItemColor: Colors.teal[500],
      // backgroundColor: Colors.white,
      // enableFeedback: false,
      // fixedColor: Colors.red,
      // showSelectedLabels: false,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedLabelStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      unselectedItemColor: Colors.black54,
      elevation: 10,
      onTap: (value) {
        print(value);
        return _goBranch(value);
      },
      items: [
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.home_outlined),
        //   label: 'Home',
        //   activeIcon: Icon(Icons.home, color: AppColors.greenNew),
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.shopping_bag_outlined),
        //   label: 'Productos',
        //   activeIcon: Icon(Icons.shopping_bag, color: AppColors.greenNew),
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Carrito',
        //   activeIcon: Icon(Icons.search, color: AppColors.greenNew),
        // ),

        BottomNavigationBarItem(
        icon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.home),
          sectionName: 'Home',
        ),
        label: 'Home',
        activeIcon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.home_outlined, color: Colors.white,),
          sectionName: 'Home',
          isActive: true,
        )),


        BottomNavigationBarItem(
        icon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.shopping_bag),
          sectionName: 'Productos',
         
        ),
        label: 'Productos',
        activeIcon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
          sectionName: 'Productos',
          isActive: true,
        )),


        BottomNavigationBarItem(
        icon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.shopping_cart),
          sectionName: 'Carrito',
        ),
        label: 'Carrito',
        activeIcon: _NavigationBarHomeActiveOrInActive(
          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
          sectionName: 'Carrito',
          isActive: true,
        )),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Carrito',
        //   activeIcon: Icon(Icons.search, color: AppColors.greenNew),
        // ),

        // BottomNavigationBarItem(
        //   icon: Icon(Icons.favorite_border),
        //   label: 'Favoritos',
        //   activeIcon: Icon(Icons.favorite, color: AppColors.greenNew),
        // ),

        // BottomNavigationBarItem(
        //   icon: Icon(Icons.monetization_on_outlined),
        //   label: 'Credito',
        //   activeIcon: Icon(Icons.monetization_on, color: AppColors.greenNew),
        // ),

        // BottomNavigationBarItem(
        // icon: Icon(Icons.search),
        // label: 'Search',
        // activeIcon: Icon(Icons.search, color:AppColors.greenNew)),

        // BottomNavigationBarItem(
        // icon: Icon(Icons.abc_outlined),
        // label: 'Buscador',
        // activeIcon: Icon(Icons.abc_outlined)),
        // BottomNavigationBarItem(
        //   icon: _NavigationBarHomeActiveOrInActive(
        //     icon: Icon(Icons.route),
        //     sectionName: 'Productos',
        //   ),
        //   label: 'Actividad',
        //   activeIcon: _NavigationBarHomeActiveOrInActive(
        //     icon: Icon(Icons.route),
        //     sectionName: 'Productos',
        //     isActive: true,
        //   ),
        // ),
        // BottomNavigationBarItem(
        //     icon: _NavigationBarHomeActiveOrInActive(
        //       icon: FontAwesomeIcons.play,
        //       sectionName: 'Videos',
        //     ),
        //     label: 'Estados',
        //     activeIcon: _NavigationBarHomeActiveOrInActive(
        //       icon: FontAwesomeIcons.play,
        //       sectionName: 'Videos',
        //       isActive: true,
        //     )
        // ),
        // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.paw, size: 20), label: 'Actividad'),
        // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.shieldDog, size: 20), label: 'Seguridad'),
      ],
    );
  }

  bool _rootInitials(BuildContext contex, int previousIndex, int currentIndex) {
    if (currentIndex == previousIndex) {
      if (currentIndex == 0) contex.go('/home-screen');
      if (currentIndex == 1) contex.go('/products');
      if (currentIndex == 2) contex.go('/cart');
      return true;
    }
    return false;
  }
}

class _NavigationBarHomeActiveOrInActive extends StatefulWidget {
  final Icon icon;
  final String sectionName;
  final bool isActive;

  const _NavigationBarHomeActiveOrInActive({
    required this.icon,
    required this.sectionName,
    this.isActive = false,
  });

  @override
  State<_NavigationBarHomeActiveOrInActive> createState() =>
      _NavigationBarHomeActiveOrInActiveState();
}

class _NavigationBarHomeActiveOrInActiveState
    extends State<_NavigationBarHomeActiveOrInActive> {
  double _w = 35;
  final double _h = 35;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {});
      _w = 85;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: (widget.isActive) ? 125 : 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: widget.isActive ? Colors.blue: Colors.white12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 5,),
          widget.icon,
          SizedBox(width: 2,),
          Flexible(
            child: Text(
              
              widget.sectionName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 2,),
        ],
      ),
    );
  }
}
