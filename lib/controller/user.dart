class User {
  final String username;
  final String password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String userid; // add this field

  User(
      {required this.username,
      required this.password,
      this.email,
      this.firstName,
      this.lastName, 
      required this.userid});

  getUserDetails() {
    return {
      "username": username,
      "password": password,
      "email": email,
      "firstname": firstName,
      "lastName": lastName,
      "userid": userid
    };
  }

  Object? toJson() {}
}
