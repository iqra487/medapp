import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/utils/config.dart';
import 'package:http/http.dart' as http; // Import the http package

import '../../utils/request.dart';

class DocProfile extends StatefulWidget {
  const DocProfile({super.key});

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  List<dynamic> userData = [];

  @override
  void initState() {
    super.initState();
    fetchDoctorData().then((data) {
      setState(() {
        userData = data;
        print(userData);
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData[0]['username'] ?? ""),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userData[0]['username'] ?? "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Pet Owner",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Config.primaryColor,
              ),
              title: Text(userData[0]['email'] ?? ""),
              onTap: () {
                // Handle email tap if needed
              },
            ),

            // You can add more user information here like pet names, pet records, etc.
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchDoctorData() async {
  await Future.delayed(Duration(seconds: 2));

  final List<dynamic> userData =
      await requestList('http://localhost:8000/api/doctors/', 'GET');

  return userData;
}

Future<List<dynamic>> requestList(String uri, String method) async {
  String? value = await storage.read(key: 'token');
  var headers = {
    'Authorization': 'token $value',
    // 'Cookie':
    //     'csrftoken=tjr58d42MagboZgX4WgjTxd0v41MlfiT; sessionid=1cjgapvyu2zzj7thgn1ea9yrhioer3nl'
  };
  var request = http.Request(method, Uri.parse(uri));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseString = await response.stream.bytesToString();
    List<dynamic> data = await json.decode(responseString) as List;
    return data;
  } else {
    throw Exception('request failed');
  }
}
