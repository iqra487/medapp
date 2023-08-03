import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For loading images from a URL

class AnimatedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.pop(
                    context); // Close the drawer when the profile picture is tapped
              },
              child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/profile_pic1.jpg')),
            ),
            otherAccountsPictures: [
              GestureDetector(
                onTap: () {
                  // Handle switching between user accounts here (if applicable)
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.of(context).pushNamed(
                  'user_profile'); // Close the drawer when a list tile is tapped
              // Handle navigation to the Appointments screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Appointments"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Appointments screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text("Pet Records"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Pet Records screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Schedule"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Schedule screen here
            },
          ),
          // Add more items here
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favorites"),
            onTap: () {
              Navigator.of(context).pushNamed(
                  'fav_page'); // Close the drawer when a list tile is tapped
              // Handle navigation to the Schedule screen here
            },
          ),
          // Add more items here
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              // Handle logout here
            },
          ),
        ],
      ),
    );
  }
}
