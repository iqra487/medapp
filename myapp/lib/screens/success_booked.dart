import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/button.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentBooked extends StatefulWidget {
  const AppointmentBooked({super.key});

  @override
  State<AppointmentBooked> createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.asset('assets/images/success.json'),
            flex: 3,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: "Appointment Booked".text.bold.size(20).make(),
          ),
          Spacer(),
          Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: "Back to Home Page",
                disable: false,
                onPressed: () => Navigator.of(context).pushNamed('main'),
              ))
        ],
      )),
    );
  }
}
