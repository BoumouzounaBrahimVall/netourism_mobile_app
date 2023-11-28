import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netourism_mobile_app/models/sign_in_form_model.dart';

import '../models/sign_up_form_model.dart';
import '../services/signin/fake_signin_service.dart';
import '../services/signin/signin_service.dart';
import '../services/signin/http_signin_service.dart';
import '../services/user/http_user_service.dart';
import '../services/user/user_service.dart';

final signUpFormModelProvider = StateProvider<SignUpForm>((ref) {
  return SignUpForm();
});
final signInFormModelProvider =
    StateProvider<SignInFormModel>((ref) => SignInFormModel());

final selectedHobbiesProvider = StateProvider<List<String>>((ref) => []);
final selectedPreferencesProvider = StateProvider<List<String>>((ref) => []);
bool isFake = false;
final signinServiceProvider = Provider<SignInService>((ref) {
  return isFake
      ? FakeSignInService()
      : HttpSignInService(ref.read(userServiceProvider));
});

final userServiceProvider = Provider<UserService>((ref) {
  return HttpUserService();
});
