// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  String username;
  String email;
  UserData({
    required this.username,
    required this.email,
  });

  UserData copyWith({
    String? username,
    String? email,
  }) {
    return UserData(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserData(username: $username, email: $email)';

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.username == username && other.email == email;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode;
}
