import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/screens/main/home/home_screen_navigation_widget.dart';
import '/screens/sign_in_up/sign_in/sign_in_screen.dart';
import '/screens/sign_in_up/sign_up/sign_up_screen.dart';
import '/screens/sign_in_up/sign_up/sub_screens/preference/preference_screen.dart';
import '/screens/onbroading/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => HomeScreenNavigationWidget(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  PreferenceScreen.routeName: (context) => const PreferenceScreen(),
};
