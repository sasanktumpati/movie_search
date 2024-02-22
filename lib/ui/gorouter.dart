import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/ui/searchbox.dart';

import 'details.dart';
import 'home.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});

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
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/page2',
      builder: (context, state) => const MovieDetails(),
    ),
    GoRoute(
      path: '/searchPage',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);

void main() {
  runApp(const MainScreen());
}
