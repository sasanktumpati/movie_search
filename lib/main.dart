import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/ui/home.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderScope(
          child: HomeScreen(),
      ),
    );
  }
}
