import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/ui/searchbox.dart';
import 'package:movie_search/ui/splash.dart';

import 'ui/details.dart';
import 'ui/home.dart';

class Routing extends StatelessWidget {
  const Routing({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          brightness: Brightness.light,
          onPrimary: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsPage(
        imdbId: '',
      ),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);

void main() {
  runApp(const Routing());
}
