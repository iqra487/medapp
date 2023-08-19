// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/utils/config.dart'; // For loading images from a URL

// ignore: must_be_immutable
class AnimatedDrawer extends StatefulWidget {
  Map<String, String> userData;
  AnimatedDrawer({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Config.primaryColor),
            accountName: Text(
              widget.userData['username']!,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            accountEmail: Text(
              widget.userData['email']!,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
            ),
            // currentAccountPicture: GestureDetector(
            //   onTap: () {
            //     Navigator.pop(
            //         context); // Close the drawer when the profile picture is tapped
            //   },
            //   child: CircleAvatar(
            //       backgroundImage:
            //           AssetImage('assets/images/profile_pic1.jpg')),
            // ),
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
            leading: Icon(
              Icons.person,
              color: Config.primaryColor,
            ),
            title: Text("Profile"),
            onTap: () {
              Navigator.of(context).pushNamed('user_profile');
              // Close the drawer when a list tile is tapped
              // Handle navigation to the Appointments screen here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Config.primaryColor,
            ),
            title: Text("Appointments"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Appointments screen here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.pets,
              color: Config.primaryColor,
            ),
            title: Text("Pet Records"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Pet Records screen here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: Config.primaryColor,
            ),
            title: Text("Schedule"),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer when a list tile is tapped
              // Handle navigation to the Schedule screen here
            },
          ),
          // Add more items here
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Config.primaryColor,
            ),
            title: Text(
              "Favorites",
            ),
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
            onTap: () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: 'token');
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
