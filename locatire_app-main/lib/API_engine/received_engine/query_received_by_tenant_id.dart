import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/received.dart';
import '../url_admin.dart';

Future<List<Received>> querymyReceivedByTenantID(String id) async {
  Uri uri =
      Uri.parse(UrlAdmin().serverUrl + UrlAdmin().querymyReceivedByTenantID);

  List<Received> myReceived = [];

  try {
    final response = await http.post(uri, body: {
      'id': id,
    });
    print("response.statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      //print("map : $data");
      //print("data.length : ${data.length}");

      for (var i = 0; i < data.length; i++) {
        //print(i);
        var map = data[i];
        //print("map : $map");
        myReceived.add(Received.fromMapDBonline(data[i]));
      }
      //print("myReceived : $myReceived");
    }
  } catch (e) {
    print("e1 : $e");
  }
  return myReceived;
}
