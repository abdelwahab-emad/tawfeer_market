class UserModel {
  final String uId;
  final String firstName;
  final String lastName;  
  final String email;
  final String password;
  final String role;
  final String status;
  final DateTime createdAt;
  final String? image;

  UserModel({
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.status,
    required this.createdAt,
    this.image,
  });
}
