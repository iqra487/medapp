import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 140,
      child: GestureDetector(
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: Config.widthSize * 0.33,
                  child: Image.asset('assets/images/doctor_pic1.jpg'),
                ),
                Flexible(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      'Dr Richard'.text.bold.xl2.make(),
                      'Specialist'.text.white.xl.make(),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          '4.5'.text.sm.make(),
                          Spacer(
                            flex: 1,
                          ),
                          'Reviews'.text.make(),
                          Spacer(
                            flex: 1,
                          ),
                          '(20)'.text.make()
                        ],
                      )
                    ],
                  ),
                ))
              ],
            )),
        onTap: () {
          Navigator.of(context).pushNamed(route);
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 100,
      child: GestureDetector(
          child: Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set border radius
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
