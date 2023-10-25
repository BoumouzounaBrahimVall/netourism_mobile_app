import 'package:flutter/material.dart';
import '/screens/sign_in_up/sign_in/sign_in_screen.dart';
import '/screens/sign_in_up/sign_up/sign_up_screen.dart';
import '/screens/sign_in_up/sign_up/sub_screens/preference/preference_screen.dart';
import '/screens/onbroading/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  PreferenceScreen.routeName: (context) => const PreferenceScreen(),
};
