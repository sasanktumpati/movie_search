import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/ui/homelistview.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Your App Title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeListView(),
      ),
    );
  }
}
