import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constants/cameras.dart';
import '/constants/current_location.dart';
import '/constants/routes.dart';
import '/constants/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  curentLocation = await NetourismLocation.getLocation();
  cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netourisme',
      theme: themeData,
      routes: routes,
    );
  }
}

//const MapScreen(),