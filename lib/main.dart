// import 'package:clickbuy/firebase_options.dart';
// import 'package:clickbuy/src/config/routes/appRoute.dart';
// import 'package:clickbuy/src/config/theme/theme.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(ProviderScope(child: const MyApp()));
// } 

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final goRouter = ref.watch(goRouterProvider);
    
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerConfig: goRouter,
//       theme: lightMode(),
//     );
//   }
// }


import 'package:clickbuy/firebase_options.dart';
import 'package:clickbuy/flavors/flavor_config.dart';
import 'package:clickbuy/src/config/routes/appRoute.dart';
import 'package:clickbuy/src/config/theme/theme.dart';
import 'package:clickbuy/src/infrastructure/datasorces/product_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/datasorces/login_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/datasorces/cart_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/product_repositorie_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/login_repositorie_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/cart_repositorie_imp.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/auth/cubit/auth_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/cart/cubit/cart_cubit.dart';
import 'package:clickbuy/src/presentation/bloc/cubit/products/cubit/products_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  FlavorConfig.setupFlavor(Flavor.dev);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
    supportedLocales: const [Locale('es'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('es'),
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepository = LoginRepositorieImp(LoginDatasourcesImp());
    final cartRepository = CartRepositorieImp(CartDatasourcesImp());
    final productRepository = ProductRepositorieImp(ProductDatasourcesImp());

    

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(loginRepository)..checkSession()),
        BlocProvider(create: (_) => CartCubit(cartRepository)),
        BlocProvider(create: (_) => QuantityCubit()),
        BlocProvider(create: (_) => ProductsCubit(productRepository)..getProducts()),
        BlocProvider(create: (_) => ProductsCarruselCubit(productRepository)..getProductsCarrusel()),
        BlocProvider(create: (_) => ProductDetailCubit(productRepository)),
        BlocProvider(create: (_) => SelectedCategory()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: appRoute, // reemplaza tu goRouterProvider
        theme: lightMode(),
      ),
    );
  }
}
