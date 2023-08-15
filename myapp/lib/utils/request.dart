import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> request(String uri, String method) async {
  var headers = {
    'Authorization':
        'token 9e8d5bbab5b710744ba5dfe482f96d8ff5db308af82b0009137e78b7f223b6b2',
    'Cookie':
        'csrftoken=tjr58d42MagboZgX4WgjTxd0v41MlfiT; sessionid=1cjgapvyu2zzj7thgn1ea9yrhioer3nl'
  };
  var request = http.Request(method, Uri.parse(uri));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseString = await response.stream.bytesToString();
    print(responseString);
    Future<Map<String, dynamic>> data = await json.decode(responseString);
    return data;
  } else {
    throw Exception('request failed');
  }
}
