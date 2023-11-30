import '../../constants/failure_success.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpService {
  Future<Either<Failure, Success>> register(
      String firstName, String lastName, String mail, String password);
}
