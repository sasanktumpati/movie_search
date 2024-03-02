import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_search/ui/home.dart';

import '../services/google_signin.dart';
import '../services/networkhandler.dart';
import 'dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ConnectivityController connectivityController = ConnectivityController();
  @override
  void initState() {
    connectivityController.init();
    super.initState();
  }

  bool get _connected => connectivityController.isConnected.value;

  _loginbuttonClick() {
    CustomDialogs customDialogs = CustomDialogs();

    customDialogs.showCircularProgressDialog(context);

    if (_connected) {
      signInWithGoogle().then((User) {
        Navigator.pop(context);
        if (kDebugMode) {
          print(User);
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      });
    } else {
      Navigator.pop(context);
      customDialogs.alertDialog(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final backColor = Theme.of(context).colorScheme.background;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: backColor,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Movie Search',
                style: TextStyle(
                    fontSize: height * 0.05,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
          ),
          Positioned(
            top: height * 0.3,
            left: width * 0.05,
            right: width * 0.05,
            child: Center(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          Positioned(
            top: height * 0.8,
            left: width * 0.15,
            right: width * 0.15,
            height: height * 0.08,
            child: ElevatedButton.icon(
              onPressed: () {
                _loginbuttonClick();
              },
              icon: Image.asset(
                'assets/google.png',
                scale: height * 0.023,
              ),
              label: Text(
                'Login with Google',
                style: TextStyle(
                    color: backColor,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.023),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
