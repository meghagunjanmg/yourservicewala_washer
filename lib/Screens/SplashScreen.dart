import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourservicewala_washer/Screens/HomeScreen.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      navigateToLoginScreen();
    });
  }

  Future<void> navigateToLoginScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? is_login = prefs.getBool('is_login');

    if(is_login==true)
{
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation,
              child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          }));

}

    else if(is_login==null || is_login==false){
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                var begin = 0.0;
                var end = 1.0;
                var curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve));
                return ScaleTransition(
                  scale: animation.drive(tween),
                  child: child,
                );
              }));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
