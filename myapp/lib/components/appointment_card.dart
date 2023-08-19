// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({
    Key? key,
    required this.username,
    required this.dayTime,
    required this.specialty,
    required this.hospital,
  }) : super(key: key);
  final String? username;
  final String? dayTime;
  final String? specialty;
  final String? hospital;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Config.blueGradientColor,
        borderRadius: BorderRadius.circular(10),
        // color: Config.primaryColor
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   backgroundImage:
                  //       AssetImage('assets/images/doctor_pic1.jpg'),
                  //   radius: 50,
                  // ),
                  // SizedBox(
                  //   width: 50,
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.username}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${widget.specialty}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${widget.hospital}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                      Config.spaceSmall,

                      // Config.spaceSmall,
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ScheduleCard(
                      dayTime: widget.dayTime!,
                      borderColor: Colors.white,
                      textColor: Colors.black),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: 'Cancel'.text.white.bold.makeCentered(),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(205, 244, 67, 54)),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    child: 'Completed'.text.white.bold.makeCentered(),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(213, 33, 149, 243)),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  ScheduleCard({
    Key? key,
    required this.borderColor,
    required this.textColor,
    required this.dayTime,
  }) : super(key: key);
  final Color borderColor;
  final Color textColor;
  final String dayTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: borderColor, borderRadius: BorderRadius.circular(10)),
        // width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Text(
          "on $dayTime",
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }
}
