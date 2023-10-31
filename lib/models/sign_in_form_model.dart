class SignInFormModel {
  SignInFormModel({this.mail, this.password});
  String? mail;
  String? password;

  @override
  String toString() {
    return {
      'mail': mail,
      'password': password,
    }.toString();
  }
}
