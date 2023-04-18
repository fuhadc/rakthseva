class User {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String userid; // add this field

  User(
      {required this.username,
      required this.password,
      required this.email,
      required this.firstName,
      required this.lastName,
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

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userid': userid,
    };
  }
}
