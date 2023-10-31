import 'dart:io';

import 'package:camera/camera.dart';
import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/material.dart';

// Create a new screen to display the image.
class CameraImageEditorScreen extends StatelessWidget {
  final XFile image;

  const CameraImageEditorScreen({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final File file = File(image.path);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.file(file, fit: BoxFit.cover),
          ),
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 34,
              icon: const FeatherIcon(
                FeatherIcons.x,
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xffEE9321),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Send", style: TextStyle(color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const FeatherIcon(
                    FeatherIcons.send,
                    color: Colors.white,
                    strokeWidth: 3,
                  ))
            ],
          )),
    );
  }
}
