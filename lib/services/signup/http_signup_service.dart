import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netourism_mobile_app/constants/failure_success.dart';
import 'package:netourism_mobile_app/constants/secret.dart';
import 'package:netourism_mobile_app/services/signup/signup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';

class HttpSignUpService implements SignUpService {
  HttpSignUpService();

  @override
  Future<Either<Failure, Success>> register(
      String firstName, String lastName, String mail, String password) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        '$authUri/register',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': mail,
          'password': password,
        },
      );
      Map<String, dynamic> jsonResponse = response.data;

      final prefs = await SharedPreferences.getInstance();
      // await prefs.setString(CacheVariableNames.token, jsonResponse['token']);
      print(response);
      //final User user = await userService.getUserFromAPI();

      await prefs.setBool(CacheVariableNames.isConnected, true);

      return Right(Success(jsonResponse['message']));
    } on DioError catch (e) {
      if (e.response != null) {
        Map<String, dynamic> jsonResponse = e.response!.data;
        return Left(Failure(jsonResponse["message"]));
      } else {
        return Left(Failure('Veuillez vérifier votre connexion internet.'));
      }
    }
  }
}
