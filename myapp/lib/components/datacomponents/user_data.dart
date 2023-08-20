import 'dart:convert';

class Hospital {
  final int id;
  final String name;

  Hospital({
    required this.id,
    required this.name,
  });
}

class Doctor {
  final int id;
  final String name;
  final String email;
  final String description;
  final int experience;
  final int userId;
  final List<Hospital> hospitals;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.experience,
    required this.userId,
    required this.hospitals,
  });
}

List<Doctor> parseDoctors(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Doctor>((json) {
    List<Hospital> hospitals =
        (json['hospitals'] as List<dynamic>).map<Hospital>((h) {
      return Hospital(
        id: h['id'],
        name: h['name'],
      );
    }).toList();

    return Doctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      description: json['description'],
      experience: json['experience'],
      userId: json['user_id'],
      hospitals: hospitals,
    );
  }).toList();
}

Doctor parseDoctor(String responseBody) {
  final parsed = json.decode(responseBody);

  List<Hospital> hospitals =
      (parsed['hospitals'] as List<dynamic>).map<Hospital>((h) {
    return Hospital(
      id: h['id'],
      name: h['name'],
    );
  }).toList();

  return Doctor(
    id: parsed['id'],
    name: parsed['name'],
    email: parsed['email'],
    description: parsed['description'],
    experience: parsed['experience'],
    userId: parsed['user_id'],
    hospitals: hospitals,
  );
}
