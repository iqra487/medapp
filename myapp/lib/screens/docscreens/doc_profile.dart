import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:http/http.dart' as http; // Import the http package

import '../../utils/request.dart';

class DocProfile extends StatefulWidget {
  const DocProfile({super.key});

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchDoctorData().then((data) {
      setState(() {
        userData = data;
        print(userData);
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userData['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Pet Owner",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Config.primaryColor,
              ),
              title: Text(userData['name']),
              onTap: () {
                // Handle email tap if needed
              },
            ),

            // You can add more user information here like pet names, pet records, etc.
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchDoctorData() async {
  await Future.delayed(Duration(seconds: 2));

  final Map<String, dynamic> userData =
      await request('http://localhost:8000/api/user_profile/', 'GET');

  return userData;
}
