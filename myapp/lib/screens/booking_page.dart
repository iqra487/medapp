import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../components/custom_appbar.dart';
import '../components/datacomponents/user_data.dart';
import '../utils/config.dart';
//appointment booking page

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late int doctorId;
  late Doctor doctor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the arguments passed from the previous screen
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      doctorId = arguments['doctorId'] as int;
      doctor = arguments['doctor'] as Doctor;
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
                    "${index + 9}:00 ${index + 9 < 11 ? "PM" : "AM"}",
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
                onPressed: () {
                  if (_timeSelected && _dateSelected) {
                    DateTime selectedDate = _currentDay;
                    int selectedHour = _currentIndex! + 9;
                    String amPm = selectedHour < 12 ? 'AM' : 'PM';
                    selectedHour = selectedHour % 12;
                    String selectedTime = '$selectedHour:00 $amPm';

                    // Now you can use the selectedDate and selectedTime as needed
                    // For example, you can pass them to the appointment confirmation page.
                    Navigator.of(context).pushNamed(
                      'success_page',
                      arguments: {
                        'selectedDate': selectedDate,
                        'selectedTime': selectedTime,
                      },
                    );
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
