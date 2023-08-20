import 'package:flutter/material.dart';
import 'package:myapp/components/appointment_card.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';
//this page include appointment details like upcoming, completed and canceled appointments that user have had so far

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, completed, canceled }

class _AppointmentPageState extends State<AppointmentPage> {
  //appointments will be filtered depending upon their status

  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules =
      //hardcoded doctors data, it doesnot include about and description of the data but it would also be required
      [
    {
      "doctor_name": "Pawan Kumar",
      "doctor_profile": "assets/images/doctor_pic1.jpg",
      "Category": "general physician",
      "status": FilterStatus.upcoming
    },
    {
      "doctor_name": "Dr Osama",
      "doctor_profile": "assets/images/doctor_pic1.jpg",
      "Category": "surgeon",
      "status": FilterStatus.completed
    },
    {
      "doctor_name": "Maaz kamal",
      "doctor_profile": "assets/images/doctor_pic1.jpg",
      "Category": "general physician",
      "status": FilterStatus.completed
    },
    {
      "doctor_name": "Dr abudl qadeer",
      "doctor_profile": "assets/images/doctor_pic1.jpg",
      "Category": "general physician",
      "status": FilterStatus.canceled
    }
  ];

  @override
  Widget build(BuildContext context) {
    List filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
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
          Expanded(
              child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder: (context, index) {
                    var _schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      margin: !isLastElement
                          ? EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(_schedule['doctor_profile']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _schedule['doctor_name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _schedule['Category'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ScheduleCard(
                                dayTime: 'Mon 11:59AM',
                                borderColor: Config.primaryColor,
                                textColor: Colors.white,
                              ),
                            ]),
                      ),
                    );
                  }))
        ],
      ),
    ));
  }
}
