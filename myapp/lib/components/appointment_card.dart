import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/doctor_pic1.jpg'),
                    radius: 50,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dr Pawan Kumar".text.white.bold.xl.make(),
                      SizedBox(height: 2),
                      "General Physician".text.white.make(),
                      Config.spaceSmall,
                      ScheduleCard(),
                      Config.spaceSmall,
                    ],
                  ),
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
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        // width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: "July 5th, 9:00AM".text.bold.black.xl.makeCentered());
  }
}
// child: Row(
//   // crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Icon(
//       Icons.calendar_today,
//       color: Colors.black,
//       size: 15,
//     ),
//     SizedBox(
//       width: 3,
//     ),
//     "Monday 11/28/22".text.black.bold.make(),
//     SizedBox(
//       width: 10,
//     ),
//     Icon(
//       Icons.access_alarm,
//       color: Colors.black,
//       size: 17,
//     ),
//     SizedBox(
//       width: 3,
//     ),
//     Flexible(child: "2:00PM".text.black.bold.make())
//   ],
//       // ),
//     );
//   }
// }
