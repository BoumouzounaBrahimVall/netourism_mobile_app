import '../../models/user_model.dart';

abstract class UserService {
  Future<User> getUserFromApi();
}
