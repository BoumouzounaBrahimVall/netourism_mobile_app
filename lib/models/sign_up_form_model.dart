class SignUpForm {
  SignUpForm({
    this.firstName,
    this.lastName,
    this.mail,
    this.password,
    this.confirmPassword,
    this.preferedPlaces,
    this.preferedHobbies,
  });
  String? firstName;
  String? lastName;
  String? mail;
  String? password;
  String? confirmPassword;
  List<String>? preferedPlaces;
  List<String>? preferedHobbies;

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
