import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/components/appointment_card.dart'; // Import the AppointmentCard widget
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http; // Import the http package

import '../components/datacomponents/user_data.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, completed, canceled }

class _AppointmentPageState extends State<AppointmentPage> {
  late int userId;
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<Appointment> appointments = [];
  Future<Map<String, dynamic>> getUserDataFromStorage() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final userDataString = await storage.read(key: 'userData');

    if (userDataString != null) {
      return json.decode(userDataString);
    } else {
      return {}; // Return an empty map if no data is found
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDataAndAppointments();
  }

  Future<void> fetchUserDataAndAppointments() async {
    try {
      final token = await getUserTokenFromStorage();
      if (mounted) {
        await fetchAppointments(token);
      }
    } catch (error) {
      print('Error fetching user data and appointments: $error');
    }
  }

  Future fetchAppointments(String token) async {
    try {
      List<Appointment> fetchedAppointments =
          await fetchAppointmentsData(token);
      setState(() {
        appointments = fetchedAppointments;
        print(appointments);
      });
    } catch (error) {
      print('Error fetching appointments: $error');
    }
  }

  Future<String> getUserTokenFromStorage() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    if (token != null) {
      return token;
    } else {
      throw Exception('Token not found');
    }
  }

  Widget build(BuildContext context) {
    List<Appointment> filteredSchedules = appointments.where((appointment) {
      if (status == FilterStatus.upcoming) {
        return appointment.status == 'pending_approval';
      } else if (status == FilterStatus.completed) {
        return appointment.status == 'completed';
      } else if (status == FilterStatus.canceled) {
        return appointment.status == 'canceled';
      }
      return false;
    }).toList();

    return SafeArea(
        //decoration
        child: Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          "Appointment Schedule".text.bold.xl2.makeCentered(),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            //checking status of appointmnents
                            if (filterStatus == FilterStatus.upcoming) {
                              status = FilterStatus.upcoming;
                              _alignment = Alignment.centerLeft;
                            } else if (filterStatus == FilterStatus.completed) {
                              status = FilterStatus.completed;
                              _alignment = Alignment.center;
                            } else if (filterStatus == FilterStatus.canceled) {
                              status = FilterStatus.canceled;
                              _alignment = Alignment.centerRight;
                            }
                          });
                        },
                        child: Center(child: Text(filterStatus.name)),
                      ))
                  ],
                ),
              ),
              //decoration
              AnimatedAlign(
                alignment: _alignment,
                duration: Duration(milliseconds: 200),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      status.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //appointment lists
          Config.spaceSmall,
          Column(
            children: List.generate(appointments.length, (index) {
              Appointment appointment = appointments[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to Doctor Details screen with doctor's ID
                },
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: filteredSchedules.length,
                      itemBuilder: (context, index) {
                        var _schedule = filteredSchedules[index];
                        bool isLastElement =
                            filteredSchedules.length + 1 == index;

                        return AppointmentCard(
                          username: _schedule.patient.username,
                          dayTime: _schedule.time,
                          hospital: _schedule.doctor.hospitals[0]
                              .name, // Assuming doctor has a list of hospitals
                          status: _schedule.status,
                        );
                      },
                    )),
                    Config.spaceSmall
                  ],
                ),
              );
            }).toList(),
          ),

          // Expanded(
          //     child: ListView.builder(
          //         itemCount: filteredSchedules.length,
          //         itemBuilder: (context, index) {
          //           var _schedule = filteredSchedules[index];
          //           bool isLastElement = filteredSchedules.length + 1 == index;
          //           return Card(
          //             shape: RoundedRectangleBorder(
          //                 side: const BorderSide(color: Colors.grey),
          //                 borderRadius: BorderRadius.circular(20)),
          //             margin: !isLastElement
          //                 ? EdgeInsets.only(bottom: 20)
          //                 : EdgeInsets.zero,
          //             child: Padding(
          //               padding: EdgeInsets.all(20),
          //               child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.stretch,
          //                   children: [
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: 10,
          //                         ),
          //                         Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               _schedule.doctor.name,
          //                               style: TextStyle(
          //                                   fontWeight: FontWeight.w700,
          //                                   color: Colors.black),
          //                             ),
          //                             SizedBox(
          //                               height: 5,
          //                             ),
          //                             // Text(
          //                             //   _schedule.doctor.,
          //                             //   style: TextStyle(
          //                             //       fontWeight: FontWeight.w700,
          //                             //       color: Colors.grey),
          //                             // ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: 20,
          //                     ),
          //                     ScheduleCard(
          //                       borderColor: Color.fromARGB(255, 61, 100, 158),
          //                       textColor: Colors.white,
          //                       dayTime: 'helo',
          //                     ),
          //                   ]),
          //             ),
          //           );
          //         }))
        ],
      ),
    ));
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

FlutterSecureStorage storage = FlutterSecureStorage();

Future<List<Appointment>> fetchAppointmentsData(String token) async {
  var headers = {
    'Authorization': 'token $token', // Include the token in headers
    // Add other headers if needed
  };

  var uri = Uri.parse(
      'http://localhost:8000/api/doctors/appointments/'); // Replace with your API URL
  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      print(response.body);

      return parseAppointments(response.body);
    } else {
      throw Exception('No appointment data found');
    }
  } else {
    throw Exception('Failed to fetch appointments');
  }
}
