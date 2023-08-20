// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myapp/components/datacomponents/user_data.dart';
import 'package:myapp/utils/config.dart';

import '../utils/request.dart';

class UserProfile extends StatefulWidget {
  UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> userData = {}; // To store fetched user data

  // late final UserData user;

  @override
  void initState() {
    super.initState();
    fetchUserData().then((data) {
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
        title: Text(userData['username']!),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userData['username'] ?? "",
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
              title: Text(userData['email'] ?? ""),
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

Future<Map<String, dynamic>> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));

  final Map<String, dynamic> userData =
      await request('http://localhost:8000/api/user_profile/', 'GET');

  return userData;
}
