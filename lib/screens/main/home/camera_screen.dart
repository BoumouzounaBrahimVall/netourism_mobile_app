import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/constants/cameras.dart';
import 'package:netourism_mobile_app/screens/main/home/camera_image_editor_screen.dart';
import 'package:netourism_mobile_app/widgets/screen_transitions_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController? controller;
  Future<XFile?>? takePictureFuture;

  Future<void> initCamera({required bool frontCamera}) async {
    controller =
        CameraController(cameras[frontCamera ? 1 : 0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) initCamera(frontCamera: false);
  }

  @override
  void dispose() {
    if (controller != null) controller!.dispose();
    super.dispose();
  }

  Future<XFile?> takePicture() async {
    if (!mounted) {
      return null;
    }

    setState(() {
      takePictureFuture = Future.sync(() => controller?.takePicture());
    });

    final XFile? image = await takePictureFuture;

    return image;
  }

// Take the picture and navigate to the new screen.
  Future<void> takePictureAndNavigate() async {
    final image = await takePicture();

    if (image != null) {
      Navigator.of(context).push(
        SlideTopRouteWidget(
          CameraImageEditorScreen(image: image),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        !controller!.value.isInitialized
            ? Container(
                color: Colors.black,
              )
            : SizedBox(
                height: height,
                width: width,
                child: Builder(
                  builder: (context) {
                    var camera = controller!.value;
                    final fullSize = MediaQuery.of(context).size;
                    final size = Size(fullSize.width,
                        fullSize.height - (Platform.isIOS ? 90 : 60));
                    double scale;
                    try {
                      scale = size.aspectRatio * camera.aspectRatio;
                    } catch (_) {
                      scale = 1;
                    }
                    if (scale < 1) scale = 1 / scale;

                    return ClipRRect(
                      child: Transform.scale(
                          scale: scale, child: CameraPreview(controller!)),
                    );
                  },
                ),
              ),
        Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                await takePictureAndNavigate();
              },
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 6),
                ),
              ),
            ))
      ],
    );
  }
}



/**
 
 import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// Uploads an image to the Spring Boot API.
Future<void> uploadImage(XFile image) async {
  final multipartFormDataBuilder = MultipartFormDataBuilder();
  multipartFormDataBuilder.addFormDataPart("file", image);

  final request = http.MultipartRequest('POST', Uri.parse('http://localhost:8080/upload'));
  request.files.add(multipartFormDataBuilder.build());

  final response = await request.send();

  if (response.statusCode == 200) {
    // The image was uploaded successfully.
  } else {
    // There was an error uploading the image.
  }
}

// Downloads an image from the Spring Boot API.
Future<XFile?> downloadImage(String fileName) async {
  final response = await http.get(Uri.parse('http://localhost:8080/images/$fileName'));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;

    // Create a temporary file to store the image.
    final tempFile = File(await getTemporaryDirectory() + '/image.jpg');

    // Write the image bytes to the temporary file.
    await tempFile.writeAsBytes(bytes);

    return XFile(tempFile.path);
  } else {
    // There was an error downloading the image.
    return null;
  }
}

-----
// Upload an image.
final image = XFile('/path/to/image.jpg');

await uploadImage(image);

// Download an image.
final fileName = 'image.jpg';

final XFile? downloadedImage = await downloadImage(fileName);

// Display the downloaded image.
// TODO: Implement this code to display the downloaded image.


------------------------Spring boot 
@PostMapping("/upload")
public ResponseEntity<Void> uploadImage(@RequestParam("file") MultipartFile file) {
  // Validate the file.
  if (!file.getContentType().equals(MediaType.IMAGE_JPEG)) {
    return ResponseEntity.badRequest().build();
  }

  // Save the file to Cassandra.
  String fileName = UUID.randomUUID().toString();
  // TODO: Implement this method to save the file to Cassandra.
  saveFileToCassandra(fileName, file.getBytes());

  // Return a success response.
  return ResponseEntity.ok().build();
}

@GetMapping("/images/{fileName}")
public ResponseEntity<byte[]> getImage(@PathVariable("fileName") String fileName) {
  // Get the file from Cassandra.
  // TODO: Implement this method to get the file from Cassandra.
  byte[] bytes = getFileFromCassandra(fileName);

  // Return the file.
  return ResponseEntity.ok(bytes).contentType(MediaType.IMAGE_JPEG).build();
}
 */