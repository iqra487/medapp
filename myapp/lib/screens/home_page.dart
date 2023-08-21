import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/appointment_card.dart';
import 'package:myapp/components/doctor_card.dart';
import 'package:myapp/components/search_field.dart';
import 'package:myapp/screens/doctor_details.dart';
import 'package:myapp/utils/config.dart';
import 'package:myapp/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/datacomponents/user_data.dart';
import 'animated_drawer.dart'; // Import the http package

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Map<String, dynamic> userData = {}; // To store fetched user data
  List<Doctor> doctorList = [];

  @override
  void initState() {
    super.initState();
    fetchUserData().then((data) {
      setState(() {
        userData = data;
      });
      fetchDoctorData().then((doctors) {
        setState(() {
          doctorList = doctors;
        });
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

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

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      key: _scaffoldKey,
      body: (userData.isNotEmpty)
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _openDrawer(context),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: null,
                          child: ListTile(
                            shape: StadiumBorder(),
                            title: Text(
                              userData['username']!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            subtitle: Text(
                              "Profile",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Config.spaceSmall,

                      //category section
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      SizedBox(
                        height: Config.heightSize * 0.06,
                        child: ListView(
                          shrinkWrap: true,
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
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Config.spaceSmall,
                      //search field, user can search what they are looking for like category, animal category,areas where doctors are nearest to them
                      SearchField(),
                      Config.spaceSmall,
                      //upcoming schedule section, this should only show if there is any appointment else it should show no appointments
                      Text(
                        "Upcoming Schedule",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      AppointmentCard(
                        status: 'pending_approval',
                        username: 'Dr Usama',
                        dayTime: "Mon 11:59AM",
                        hospital: "Pet Hospital",
                      ),
                      Config.spaceSmall,
                      //
                      Text(
                        "Top Doctors",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      Column(
                        children: List.generate(doctorList.length, (index) {
                          Doctor doctor = doctorList[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to Doctor Details screen with doctor's ID
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetails(
                                    id: doctor.id,
                                    // doctor: doctor,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                DoctorCard(
                                  id: doctor.id,
                                  username: doctor.name,
                                  hospitals: doctor.hospitals
                                      .map((element) => element.name)
                                      .join(', '), // Combine hospital names
                                  experience: doctor.experience.toString(),
                                ),
                                Config.spaceSmall
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: const CircularProgressIndicator()),
      drawer: AnimatedDrawer(userData: userData),
    );
  }
}

// ... (your fetchUserData and fetchDoctorData methods)

Future<Map<String, dynamic>> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));

  final Map<String, dynamic> userData =
      await request('http://localhost:8000/api/user_profile/', 'GET');

  // Save the user data to secure storage
  final storage = FlutterSecureStorage();
  await storage.write(key: 'userData', value: json.encode(userData));

  return userData;
}

FlutterSecureStorage storage = FlutterSecureStorage();

Future<List<Doctor>> fetchDoctorData() async {
  String? value = await storage.read(key: 'token');
  var headers = {
    'Authorization': 'token $value',
    // Add other headers if needed
  };

  var uri = Uri.parse(
      'http://localhost:8000/api/doctors/'); // Replace with your API URL
  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    return parseDoctors(response.body);
  } else {
    throw Exception('Request failed');
  }
}
