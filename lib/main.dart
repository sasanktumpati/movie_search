import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:movie_search/ui/homelistview.dart';

class g_translate_app extends StatelessWidget {

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeListView(),
      ),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}




void main() {
  runApp(g_translate_app());
}


