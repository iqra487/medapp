// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:myapp/components/button.dart';
import 'package:myapp/components/custom_appbar.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/datacomponents/user_data.dart';

class DoctorDetails extends StatefulWidget {
  final int id;
  DoctorDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isFav = false;
  Doctor? doctor; // Variable to store the doctor's data

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch the doctor's data based on the id
  }

  Future<void> fetchDoctorDetails() async {
    // Fetch doctor's data using the widget.id
    try {
      Doctor fetchedDoctor = await fetchDoctorData(
          widget.id); // Implement this method to fetch doctor's data
      setState(() {
        doctor = fetchedDoctor;
      });
    } catch (error) {
      print('Error fetching doctor details: $error');
    }
  }

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
        body: (doctor != null)
            ? SafeArea(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    //doc name, picture and qualification details, hospital names
                    AboutDoctor(
                      doctor: doctor!,
                    ),
                    //description, experience , reviews
                    // DetailBody(
                    //   doctor: doctor!,
                    // ),
                    //book appointment button; navigates to booking page
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Button(
                        width: double.infinity,
                        title: 'Start chat',
                        disable: false,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            'booking_page',
                            arguments:
                                widget.id, // Pass the doctor's ID as arguments
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Button(
                        width: double.infinity,
                        title: 'Request Appointment',
                        disable: false,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            'booking_page',
                            arguments: {
                              'doctorId': widget.id,
                              'doctor': doctor,
                            },
// Pass the doctor's ID as arguments
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class AboutDoctor extends StatelessWidget {
  final Doctor doctor; // Add this line to accept a Doctor instance
  const AboutDoctor({required this.doctor});

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Config.spaceMedium,
            Text(
              doctor.name,
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
            Config.spaceSmall,
            Text(
              doctor.description,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700]),
            ),
            Config.spaceSmall,
            Text(
              "Experience: ${doctor.experience}+ Years",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700]),
            ),
            Config.spaceSmall,
            ListView.builder(
              shrinkWrap: true,
              itemCount: doctor.hospitals.length,
              itemBuilder: (context, index) {
                Hospital hospital = doctor.hospitals[index];
                return Text(
                  "Available at ${hospital.name}",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: Colors.grey[900]),
                ); // Display hospital name
              },
            ),
            Config.spaceSmall,
            Config.spaceSmall,
            Text(
              "Contact at: ${doctor.email}",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// class DetailBody extends StatelessWidget {
//   final Doctor doctor;
//   const DetailBody({
//     Key? key,
//     required this.doctor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Config().init(context);
//     return Container(
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.only(bottom: 30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Config.spaceSmall,
//           DoctorInfo(),
//           Config.spaceSmall,
//           "About Doctor".text.gray800.wide.lg.bold.make(),
//           Config.spaceSmall,
//           Text(
//             "${doctor.description}",
//             style: TextStyle(
//               fontSize: 15,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class DoctorInfo extends StatelessWidget {
//   const DoctorInfo({
//     super.key,
//   });
//   // final String value;
//   // final String label;

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         InfoCard(value: "100", label: "Patients"),
//         InfoCard(value: "10 years", label: "experience"),
//         InfoCard(value: "103", label: "Reviews")
//       ],
//     );
//   }
// }

// class InfoCard extends StatelessWidget {
//   const InfoCard({required this.value, required this.label, super.key});
//   final String label;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: Config.blueGradientColor),
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
//         child: Column(children: [
//           label.text.size(12).semiBold.white.make(),
//           SizedBox(
//             height: 10,
//           ),
//           value.text.size(15).semiBold.white.make()
//         ]),
//       ),
//     );
//   }
// }

FlutterSecureStorage storage = FlutterSecureStorage();
Future<Doctor> fetchDoctorData(int id) async {
  await Future.delayed(Duration(seconds: 2));
  String? value = await storage.read(key: 'token');
  var headers = {
    'Authorization': 'token $value',
    // Add other headers if needed
  };

  var uri = Uri.parse(
      'http://localhost:8000/api/doctors/$id/'); // Replace with your API URL
  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    return parseDoctor(response.body);
  } else {
    throw Exception('Failed to fetch doctor details');
  }
}
