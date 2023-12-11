import 'dart:io';
import 'package:flutter/material.dart';
import '../../../services/events/images_upload.dart';

class CameraImageEditorScreen extends StatefulWidget {
  const CameraImageEditorScreen({super.key, required this.file});
  final File file;

  @override
  State<CameraImageEditorScreen> createState() =>
      _CameraImageEditorScreenState();
}

// Create a new screen to display the image.
class _CameraImageEditorScreenState extends State<CameraImageEditorScreen> {
  @override
  void initState() {
    super.initState();
    //  _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.file(widget.file, fit: BoxFit.cover),
          ),
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 34,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                // strokeWidth: 3,
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
                  onPressed: () async {
                    debugPrint('------------------------------------');
                    await updateProfile(widget.file).then((value) {
                      debugPrint('$value');
                      Navigator.of(context).pop();
                      return value;
                    });
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    // strokeWidth: 3,
                  ))
            ],
          )),
    );
  }
}
