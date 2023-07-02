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
