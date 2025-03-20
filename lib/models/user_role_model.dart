class UserModel {
  String userName;
  String? id;
  String userType;
  String password;

  UserModel({
    required this.userName,
    this.id,
    required this.userType,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] ?? '', // If null, use an empty string
      id: map['id'] ?? '', // Provide a default empty string
      userType: map['userType'] ?? '', // Ensure non-null value
      password: map['password'] ?? '', // Prevent null issues
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'id': id,
      'userType': userType,
      'password': password,
    };
  }
}
