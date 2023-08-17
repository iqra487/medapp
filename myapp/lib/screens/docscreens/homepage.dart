import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/button.dart';
import '../../utils/config.dart';

class DocHomePage extends StatelessWidget {
  const DocHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.amber,
                      ),
                      shape: StadiumBorder(),
                      title: Text("Dr. Usama"),
                      // subtitle: Text("Brutus' companion"),
                    ),
                  ),
                  Config.spaceSmall,
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //doc name, picture and qualification details, hospital names
                        AboutDoctor(),
                        //description, experience , reviews
                        DetailBody(),
                        //book appointment button; navigates to booking page
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Button(
                            width: double.infinity,
                            title: 'Book Appointmentt',
                            disable: false,
                            onPressed: () {
                              Navigator.of(context).pushNamed('booking_page');
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ])))));
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.8,
            child: loremIpsum(words: 20).text.gray500.wide.base.center.make(),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.8,
            child: "Hospital name".text.gray800.wide.lg.bold.center.make(),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Config.spaceSmall,
          DoctorInfo(),
          Config.spaceSmall,
          "About ".text.gray800.wide.lg.bold.make(),
          Config.spaceSmall,
          loremIpsum(words: 20).text.gray500.wide.base.make()
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
  });
  // final String value;
  // final String label;

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoCard(value: "100", label: "Patients"),
        InfoCard(value: "10 years", label: "experience"),
        InfoCard(value: "103", label: "Reviews")
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({required this.value, required this.label, super.key});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: Config.blueGradientColor),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(children: [
          label.text.size(12).semiBold.white.make(),
          SizedBox(
            height: 10,
          ),
          value.text.size(15).semiBold.white.make()
        ]),
      ),
    );
  }
}
