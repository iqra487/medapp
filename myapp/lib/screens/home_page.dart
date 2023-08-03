import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/appointment_card.dart';
import 'package:myapp/components/doctor_card.dart';
import 'package:myapp/components/search_field.dart';
import 'package:myapp/utils/config.dart';

import 'animated_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Add this line

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
  ];
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
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
                    leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile_pic1.jpg")),
                    title: Text("John Doe"),
                    subtitle: Text("Brutus' companion"),
                  ),
                ),
              ),
              Config.spaceSmall,

              //category section
              Text(
                "Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Config.spaceSmall,
              SizedBox(
                  height: Config.heightSize * 0.07,
                  // width: Config.widthSize * 0.1,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(
                      medCat.length,
                      (index) {
                        return Container(
                          width: Config.widthSize * 0.45,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Config.spaceSmall,
              AppointmentCard(),
              Config.spaceSmall,
              //
              Text(
                "Top Doctors",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Config.spaceSmall,
              Column(
                children: List.generate(10, (index) {
                  return const DoctorCard(route: 'doc_details');
                }),
              )
              // doctors card
            ],
          ),
        )),
      ),
      drawer: AnimatedDrawer(),
    );
  }
}
