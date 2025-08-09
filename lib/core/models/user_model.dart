class UserModel {
  final String id;
  final String name;
  final String email;
  final String password; // ملاحظة: يفضل ما تخزنش الباسورد في الـ frontend
  final String role; // buyer / seller / admin
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
  });

  // عشان تحول من JSON إلى كائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // عشان تحول كائن UserModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
