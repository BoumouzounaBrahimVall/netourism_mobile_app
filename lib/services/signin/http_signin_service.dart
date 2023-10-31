import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netourism_mobile_app/constants/failure_success.dart';
import 'package:netourism_mobile_app/services/signin/signin_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../models/user_model.dart';
import '../user/user_service.dart';

class HttpSignInService implements SignInService {
  HttpSignInService(this.userService);
  final UserService userService;
  @override
  Future<Either<Failure, Success>> login(String mail, String password) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        '$baseUrl/api/user/login',
        data: {
          'email': mail,
          'password': password,
        },
      );
      Map<String, dynamic> jsonResponse = response.data;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(CacheVariableNames.token, jsonResponse['token']);

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
