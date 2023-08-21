import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Replace with your Django API endpoint URL
const apiUrl = 'http://your-django-server/api/appointments/';
FlutterSecureStorage storage = FlutterSecureStorage();

// Function to create an appointment
Future<void> createAppointment(
    int doctorId, DateTime selectedDate, String selectedTime) async {
  final token = await storage.read(key: 'token');
  final headers = {
    'Authorization': 'token $token',
    'Content-Type': 'application/json',
  };

  final data = {
    'doctor_id': doctorId,
    'date': selectedDate.toIso8601String(),
    'time': selectedTime,
    // Add other relevant data fields
  };

  final response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: jsonEncode(data));

  if (response.statusCode == 201) {
    print('Appointment created successfully');
  } else {
    print('Failed to create appointment');
  }
}

// Function to retrieve appointments
Future<List<dynamic>> getDoctorAppointments(int doctorId) async {
  final token = await storage.read(key: 'token');
  final headers = {'Authorization': 'token $token'};

  final response = await http.get(Uri.parse('$apiUrl?doctor_id=$doctorId'),
      headers: headers);

  if (response.statusCode == 200) {
    final appointments = jsonDecode(response.body);
    return appointments;
  } else {
    return []; // Handle error case
  }
}
