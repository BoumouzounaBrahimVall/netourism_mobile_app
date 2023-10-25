import 'package:flutter/material.dart';
import 'pages/preference/preference_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'pages/sign_up_page/sign_up_page.dart';

Map<String, WidgetBuilder> routes = {
  SignInPage.routeName: (context) => const PreferencePage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  PreferencePage.routeName: (context) => const PreferencePage(),
};
