import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/doctor_card.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                return DoctorCard(route: 'doc_details');
              }),
            )
          ],
        ),
      ),
    );
  }
}
