import 'dart:async';
import 'package:flutter/material.dart';
import '../sign_in_up/sign_in/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
    });
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: SizedBox(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/netourism-logo.png'),
          ],
        ))));
  }
}
