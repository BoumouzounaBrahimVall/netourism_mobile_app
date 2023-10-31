import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netourism_mobile_app/constants/constants.dart';
import 'package:netourism_mobile_app/models/user_model.dart';
import 'package:netourism_mobile_app/services/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/secret.dart';

class HttpUserService implements UserService {
  final dio = Dio();

  @override
  Future<User> getUserFromApi() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString(CacheVariableNames.token);

      final response = await dio.get("$baseUrl/api/user/get_one_user",
          options: Options(headers: {'authorization': 'Bearer $token'}));

      Map<String, dynamic> jsonResponse = response.data;

      final user = User.fromJson(jsonResponse['data']);
      await prefs.setString('user', json.encode(user.toJson()));

      return user;
    } catch (e) {
      throw (Exception('Une erreur est survenue.'));
    }
  }
}
