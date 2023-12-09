import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:netourism_mobile_app/constants/secret.dart';

Future<Map<String, String>> fetchLocationDetails(
    double latitude, double longitude) async {
  // Replace with your Mapbox access token
  final String endpoint =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$mapboxAccessToken';

  final Dio dio = Dio();
  try {
    final response = await dio.get(endpoint);
    if (response.statusCode == 200) {
      final data = response.data;
      // Parse the data to extract city and country
      final features = data['features'] as List<dynamic>;
      if (features.isNotEmpty) {
        final firstFeature = features[0];
        final context = firstFeature['context'] as List<dynamic>;
        late String city;
        late String country;
        for (var contextItem in context) {
          final contextType = contextItem['id'].toString();
          if (contextType.startsWith('place')) {
            city = contextItem['text'].toString();
          } else if (contextType.startsWith('country')) {
            country = contextItem['text'].toString();
          }
        }
        debugPrint('city: $city, country: $country');
        return {'city': city, 'country': country};
      }
    }
  } catch (e) {
    print('Error fetching location details: $e');
  }
  return {'city': "city", 'country': "country"};
  ;
}
