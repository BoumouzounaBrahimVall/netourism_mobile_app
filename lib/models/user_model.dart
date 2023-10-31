class User {
  User({
    required this.email,
    required this.firstName,
    required this.lastName,
  });
  String email;
  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      email: jsonData['email'],
    );
  }

  Map<String, String?> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
