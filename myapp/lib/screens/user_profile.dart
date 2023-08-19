import 'package:flutter/material.dart';
import 'package:myapp/components/datacomponents/user_data.dart';
import 'package:myapp/utils/config.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, String> userData = {
    "username": "iqra",
    "email": "iqra@gmail.com"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['username'] ?? ""),
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
