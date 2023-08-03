import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_pic1.jpg')),
            SizedBox(height: 16),
            Text(
              "John Doe",
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
              leading: Icon(Icons.email),
              title: Text("john.doe@example.com"),
              onTap: () {
                // Handle email tap if needed
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("+1 (123) 456-7890"),
              onTap: () {
                // Handle phone tap if needed
              },
            ),
            // You can add more user information here like pet names, pet records, etc.
          ],
        ),
      ),
    );
  }
}
