import 'package:clickbuy/src/presentation/provider/auth/login_provider.dart';
import 'package:clickbuy/src/presentation/screens/auth/login_auth_screen.dart';
import 'package:clickbuy/src/presentation/screens/auth/register_auth_screen.dart';
import 'package:clickbuy/src/presentation/screens/bottom_navigation.dart';
import 'package:clickbuy/src/presentation/screens/cart/cart_screen.dart';
import 'package:clickbuy/src/presentation/screens/home/home_screen.dart';
import 'package:clickbuy/src/presentation/screens/notfound/notfound_screens.dart';
import 'package:clickbuy/src/presentation/screens/products/products_screen.dart';
import 'package:clickbuy/src/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _sectionNavigatorKey = GlobalKey<NavigatorState>();

// Provider para GoRouter
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _sectionNavigatorKey,
    initialLocation: '/home-screen',
    
  redirect: (context, state) {
  final authState = ref.watch(loginProvider);

  return authState.when(
    data: (user) {
      final isLoggedIn = user != null;
      final goingToCart = state.fullPath == '/cart';
      final goingToLoginOrRegister = state.fullPath == '/login' || state.fullPath == '/register';
      
      
      if (!isLoggedIn) {
        // Usuario no logueado
        if (goingToCart) return '/home-screen'; // evita ir al carrito
        return null; // permite otras rutas públicas
      }

     

      // print(user != null && state.fullPath == '/login' || state.fullPath == '/register');

      // Usuario logueado: si intenta entrar a login o register, lo manda a home
      if (isLoggedIn && goingToLoginOrRegister) return '/home-screen';

      return null; // todo bien, no redirige
    },
    loading: () => null, // mientras carga login, no redirige
    error: (_, __) => '/login', // si hay error, lo manda a login
  );
},


    errorBuilder: (context, state) => const NotfoundScreens(),

    routes: [
      // Rutas públicas
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: LoginAuthScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: RegisterAuthScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/welcome',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: WelcomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      // Shell navigation (rutas protegidas)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home-screen',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: HomeScreen(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/product',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: ProductsScreen(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: CartScreen(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});