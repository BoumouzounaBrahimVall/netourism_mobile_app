import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/constants/secret.dart';
import 'package:http/http.dart' as http;

Future<http.StreamedResponse> updateProfile(File? data) async {
  LatLng curentLocation = await NetourismLocation.getLocation();
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
    'user_id': '1'
  });
  request.fields.addAll(fields);
  http.StreamedResponse response = await request.send();
  return response;
}
