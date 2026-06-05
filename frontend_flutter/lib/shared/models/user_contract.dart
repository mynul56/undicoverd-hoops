class UserContract {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String role;

  UserContract({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.role,
  });

  factory UserContract.fromJson(Map<String, dynamic> json) {
    return UserContract(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    };
  }
}
