import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sign_un_form_model.dart';

final signupFormModelProvider = StateProvider<SignUpFormModel>((ref) {
  return SignUpFormModel();
});
