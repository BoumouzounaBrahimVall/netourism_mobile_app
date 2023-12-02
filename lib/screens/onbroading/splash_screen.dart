import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/constants/cameras.dart';
import 'package:netourism_mobile_app/constants/constants.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/screens/main/home/home_screen_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sign_in_up/sign_in/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();

      bool isConnected = prefs.getBool(CacheVariableNames.isConnected) ?? false;
      if (isConnected) {
        Navigator.of(context)
            .pushReplacementNamed(HomeScreenNavigationWidget.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
      }
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
