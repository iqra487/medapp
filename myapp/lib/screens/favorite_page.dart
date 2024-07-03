import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/custom_appbar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/doctor_card.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  Map docData = {
    "username": "Dr Usama",
    "specialist": "General Physician",
    "hospitals": "Pet Hospital",
    "experience": "4 years"
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: "Favorites",
        icon: const FaIcon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            children: [
              "Favourites".text.size(18).bold.make(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return DoctorCard(
                    id: 1,
                    username: docData['username'],
                    hospitals: docData['hospitals'],
                    experience: docData['experince'],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
