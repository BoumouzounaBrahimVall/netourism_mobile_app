import '../../constants/failure_success.dart';
import 'package:dartz/dartz.dart';

abstract class SignInService {
  Future<Either<Failure, Success>> login(String mail, String password);
}
