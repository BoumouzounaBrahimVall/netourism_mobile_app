import 'dart:async';

import 'package:flutter/material.dart';

import '../sign_in/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
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
