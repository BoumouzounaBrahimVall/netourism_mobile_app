import 'package:dartz/dartz.dart';
import './../../constants/failure_success.dart';
import './../../services/signin/signin_service.dart';
import './../../constants/failure_success.dart';

class FakeSignInService implements SignInService {
  @override
  Future<Either<Failure, Success>> login(String mail, String password) async {
    String? failureMessage;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mail == 'netourisme@gmail.com' && password == '12345678') {
      return Right(Success('Connexion réussie.'));
    } else if (password.isEmpty) {
      failureMessage = 'Veuillez taper votre mot de passe.';
    } else {
      failureMessage = 'Les identifiants fournis sont incorrects.';
    }
    return Left(Failure(failureMessage));
  }
}
