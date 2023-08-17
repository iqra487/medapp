import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/sign_up_form.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();
Future<Map<String, dynamic>> request(String uri, String method) async {
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
    Map<String, dynamic> data = await json.decode(responseString);
    print(data);
    return data;
  } else {
    throw Exception('request failed');
  }
}
