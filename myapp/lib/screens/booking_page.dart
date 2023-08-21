// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:intl/intl.dart';
import 'package:myapp/components/button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/custom_appbar.dart';
import '../components/datacomponents/user_data.dart';
import '../utils/appointmentRequest.dart';
import '../utils/config.dart';
import 'doctor_details.dart';

//appointment booking page

class BookingPage extends StatefulWidget {
  final int doctorId;
  const BookingPage({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Doctor? doctor; // Variable to store the doctor's data
  int? userId;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   // Retrieve the arguments passed from the previous screen
  //   final Map<String, dynamic>? arguments =
  //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

  //   if (arguments != null) {
  //     doctorId = arguments['doctorId'] as int?;
  //     doctor = arguments['doctor'] as Doctor;
  //     print(doctorId);
  //   }
  // }
  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch the doctor's data based on the id
    getUserDataFromStorage().then((userData) {
      setState(() {
        userId = userData['id']; // Extract the user ID from userData
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

  Future<void> fetchDoctorDetails() async {
    // Fetch doctor's data using the widget.id
    try {
      Doctor fetchedDoctor = await fetchDoctorData(
          widget.doctorId); // Implement this method to fetch doctor's data
      setState(() {
        doctor = fetchedDoctor;
      });
    } catch (error) {
      print('Error fetching doctor details: $error');
    }
  }

  Future<Map<String, dynamic>> getUserDataFromStorage() async {
    final storage = FlutterSecureStorage();
    final userDataString = await storage.read(key: 'userData');

    if (userDataString != null) {
      return json.decode(userDataString);
    } else {
      return {}; // Return an empty map if no data is found
    }
  }

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _timeSelected = false;
  bool _dateSelected = false;
  @override
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: "Appointment",
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(children: <Widget>[
              _tableCalendar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: Center(
                  child: "Select Consultation Time".text.bold.xl2.black.make(),
                ),
              ),
            ]),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                    _timeSelected = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          _currentIndex == index ? Colors.white : Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex == index ? Config.primaryColor : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${(index + 9) % 12 == 0 ? 12 : (index + 9) % 12}:00 ${(index + 9) < 12 ? "AM" : "PM"}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == index ? Colors.white : null,
                    ),
                  ),
                ),
              );
            }, childCount: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Button(
                width: double.infinity,
                title: "Make Appointment",
                disable: _timeSelected && _dateSelected ? false : true,
                onPressed: () async {
                  if (_timeSelected &&
                      _dateSelected &&
                      widget.doctorId != null &&
                      userId != null) {
                    print(userId);
                    DateTime selectedDate = _currentDay;
                    int selectedHour = _currentIndex! + 9;
                    selectedHour = selectedHour % 12;
                    String selectedTime = '$selectedHour:00';

                    // Format the selectedDate as YYYY-MM-DD
                    // String formattedDate =
                    //     DateFormat('yyyy-MM-dd').format(selectedDate);

                    // Send the appointment data to the backend
                    try {
                      final response = await http.post(
                        Uri.parse(
                            'http://localhost:8000/api/doctors/appointments/'),
                        body: {
                          'patient_id': userId!.toString(),

                          'date': selectedDate
                              .toLocal()
                              .toString()
                              .split(' ')[0], // Use the formatted date
                          'time': selectedTime,
                          'doctor_id': widget.doctorId.toString(),
                        },
                      );

                      if (response.statusCode == 201) {
                        // Appointment created successfully, navigate to confirmation page
                        Navigator.of(context).pushNamed(
                          'success_page',
                        );
                      } else {
                        // Handle error cases
                        print('Failed to create appointment');
                      }
                    } catch (e) {
                      print('Error creating appointment: $e');
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
