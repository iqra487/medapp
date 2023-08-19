import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/appointment_card.dart';
import 'package:myapp/components/doctor_card.dart';
import 'package:myapp/components/search_field.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/utils/config.dart';
import 'package:myapp/utils/request.dart';

import 'package:velocity_x/velocity_x.dart';

import '../components/datacomponents/user_data.dart';
import 'animated_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Map<String, dynamic> userData = {}; // To store fetched user data

  late final UserData user;

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

  void _openDrawer(BuildContext context) {
    if (_scaffoldKey.currentState != null) {
      // Check for null safety
      _scaffoldKey.currentState!
          .openDrawer(); // Use _scaffoldKey to open the drawer
    }
  }

  //categories initialized
  List<Map<String, dynamic>> medCat = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    {"icon": FontAwesomeIcons.userDoctor, "category": "Specialists"},
    {"icon": FontAwesomeIcons.userDoctor, "category": "Surgeon"},
  ];
  Map<String, String> usernewData = {
    "username": "iqra",
    "email": "iqra@gmail.com"
  };
  Map docData = {
    "username": "Dr Usama",
    "specialist": "General Physician",
    "hospitals": "Pet Hospital",
    "experience": "4 years"
  };
  @override
  Widget build(BuildContext context) {
    // final username = userData['username'] as String;

    Config().init(context);

    return Scaffold(
      key: _scaffoldKey,
      body: (userData != null)
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Card(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       //username and user profile picture
                    //       Text(
                    //         "UserName",
                    //         style:
                    //             TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    //       ),
                    //       SizedBox(
                    //         child: CircleAvatar(
                    //           radius: 30,
                    //           backgroundImage:
                    //               AssetImage('assets/images/profile_pic1.jpg'),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    GestureDetector(
                      onTap: () => _openDrawer(context),
                      child: Card(
                        elevation: null,
                        child: ListTile(
                          shape: StadiumBorder(),
                          title: Text(
                            userData['username']!,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontStyle: FontStyle.italic),
                          ),
                          subtitle: Text(
                            "Profile",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),

                    Config.spaceSmall,

                    //category section
                    Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    SizedBox(
                        height: Config.heightSize * 0.06,
                        // width: Config.widthSize * 0.1,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List<Widget>.generate(
                            medCat.length,
                            (index) {
                              return Container(
                                width: Config.widthSize * 0.4,
                                child: Card(
                                  margin: const EdgeInsets.only(right: 20),
                                  color: Config.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        FaIcon(
                                          medCat[index]["icon"],
                                          color: Colors.white,
                                        ),
                                        Text(
                                          medCat[index]["category"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                    Config.spaceSmall,
                    //search field, user can search what they are looking for like category, animal category,areas where doctors are nearest to them
                    SearchField(),
                    Config.spaceSmall,
                    //upcoming schedule section, this should only show if there is any appointment else it should show no appointments
                    Text(
                      "Upcoming Schedule",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    AppointmentCard(
                      username: docData['username'],
                      specialty: docData['specialist'],
                      dayTime: "Mon 11:59AM",
                      hospital: docData['hospitals'],
                    ),
                    Config.spaceSmall,
                    //
                    Text(
                      "Top Doctors",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    Column(
                      children: List.generate(10, (index) {
                        return DoctorCard(
                          route: 'doc_details',
                          username: docData['username'],
                          specialty: docData['specialist'],
                          hospitals: docData['hospitals'],
                          experience: docData['experince'],
                        );
                        ;
                      }),
                    )
                    // doctors card
                  ],
                ),
              )),
            )
          : CircularProgressIndicator(),
      drawer: AnimatedDrawer(userData: usernewData),
    );
  }
}

Future<Map<String, dynamic>> fetchUserData() async {
  final Map<String, dynamic> userData =
      await request('http://localhost:8000/api/user_profile/', 'GET');

  return userData;
}
