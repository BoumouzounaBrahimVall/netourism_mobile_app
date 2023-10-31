class SignUpFormModel {
  SignUpFormModel(
      {this.firstName,
      this.lastName,
      this.mail,
      this.password,
      this.confirmPassword});
  String? firstName;
  String? lastName;
  String? mail;
  String? password;
  String? confirmPassword;

  @override
  String toString() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'mail': mail,
      'password': password,
      'password confirmation ': confirmPassword,
    }.toString();
  }
}
