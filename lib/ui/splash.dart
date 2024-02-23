import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.movie_outlined,
              size: 200,
            )



          ),
          SizedBox(height: 10,),
          CircularProgressIndicator(),
        ],
      ),
      );

  }
}