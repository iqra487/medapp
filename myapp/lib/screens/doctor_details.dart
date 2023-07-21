import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/components/custom_appbar.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
//this page is for doctor details which includes doctor's name, picture, details, short desription etc

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: CustomAppBar(
        appTitle: 'About Doctor',
        icon: const FaIcon(Icons.arrow_back),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: isFav
                ? FaIcon(Icons.favorite_rounded)
                : FaIcon(Icons.favorite_border),
            color: Colors.red,
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
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
      )),
    );
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
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage('assets/images/doctor_pic1.jpg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          "Dr Richard".text.xl3.bold.black.makeCentered(),
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
          "About Doctor".text.gray800.wide.lg.bold.make(),
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
