// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    Key? key,
    required this.route,
    required this.username,
    required this.specialty,
    required this.hospitals,
    required this.experience,
  }) : super(key: key);
  final String route;
  final String? username;
  final String? specialty;
  final String? hospitals;
  final String? experience;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 140,
      child: GestureDetector(
        child: Card(
            color: Color.fromARGB(255, 249, 249, 249),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: Config.primaryColor,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username!,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "Specialty:   ${widget.specialty!}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "Available at:  ${widget.hospitals!}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.star,
                        //       color: Colors.yellow,
                        //       size: 14,
                        //     ),
                        //     SizedBox(
                        //       width: 12,
                        //     ),
                        //     '4.5'.text.sm.make(),
                        //     SizedBox(
                        //       width: 12,
                        //     ),
                        //     'Reviews'.text.make(),
                        //     SizedBox(
                        //       width: 12,
                        //     ),
                        //     '(20)'.text.make()
                        //   ],
                        // )
                      ],
                    ),
                  )),
                  SizedBox(
                    width: Config.widthSize * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: StadiumBorder(),
                          maximumSize: Size(70, 50),
                          backgroundColor: Config.primaryColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book ",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            " Appointment",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("booking_page");
                      },
                    ),
                  ),
                ],
              ),
            )),
        onTap: () {
          Navigator.of(context).pushNamed(widget.route);
        },
      ),
    );
  }
}

class DoctorChatCard extends StatelessWidget {
  const DoctorChatCard({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 100,
      child: GestureDetector(
          child: Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Set border radius
          // side: BorderSide(color: Colors.grey),
        ),
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/doctor_pic1.jpg'),
            maxRadius: 30,
          ),
          title: "Dr. Richard".text.xl.bold.make(),
          trailing: "11:59AM".text.sm.make(),
          subtitle: "okay, thanks".text.medium.make(),
        ),
      )),
    );
  }
}
