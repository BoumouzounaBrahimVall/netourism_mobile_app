import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netourism_mobile_app/constants/cameras.dart';
import 'package:netourism_mobile_app/constants/constants.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/services/events/images_upload.dart';
import '/constants/routes.dart';
import '/constants/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  curentLocation = await NetourismLocation.getLocation();
  eventLocations = await fetchLocations();

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