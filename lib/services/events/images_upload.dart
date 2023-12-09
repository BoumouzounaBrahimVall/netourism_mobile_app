import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/constants/secret.dart';
import 'package:http/http.dart' as http;

Future<http.StreamedResponse> updateProfile(File? data) async {
  http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(mediaServiceUri));
  // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
  if (data != null) {
    data;
    request.files.add(http.MultipartFile(
        'image', data.readAsBytes().asStream(), data.lengthSync(),
        filename: data.path.split('/').last));
  }

  Map<String, String> fields = Map();
  fields.addAll(<String, String>{
    'lat': curentLocation.latitude.toString(),
    'long': curentLocation.longitude.toString(),
    'user_id': '${Random().nextInt(20)}',
  });
  request.fields.addAll(fields);
  http.StreamedResponse response = await request.send();
  return response;
}

Future<List<String>> fetchImages(LatLng location) async {
  final url =
      '$getImegesByLocationUri/${location.latitude}/${location.longitude}/750';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }
    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the "imagePaths" list from the response
      final List<dynamic> imagePaths = responseData['message']['imagePaths'];

      // Convert the dynamic list to a list of strings
      List<String> imageList =
          imagePaths.map((item) => item.toString()).toList();

      return imageList;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load images');
    }
  } catch (e) {
    return [];
    // Handle any exceptions that occurred during the request
    throw Exception('Error: $e');
  }
}

Future<List<LatLng>> fetchLocations() async {
  const url = getLocationsUri;

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final List<dynamic> responseData = json.decode(response.body);

      // Extract the "imagePaths" list from the response
      //final List<dynamic> imagePaths = responseData['message']['imagePaths'];
      List<LatLng> locations = responseData.map((locationData) {
        final coordinates = locationData['point']['coordinates'];
        final double latitude = coordinates[1]; // Latitude
        final double longitude = coordinates[0]; // Longitude
        return LatLng(latitude, longitude);
      }).toList();

      return locations;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load images');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the request
    throw Exception('Error: $e');
  }
}
