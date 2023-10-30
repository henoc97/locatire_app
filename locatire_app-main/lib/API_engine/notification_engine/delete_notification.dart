import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';

Future<int?> deleteNotification(String notifcationID) async {
  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().deleteNotification);
  ConvertInIntFromApi? isDone;
  print("run : $notifcationID");
  try {
    final response = await http.post(uri, body: {
      'notifcationID': notifcationID,
    });
    print("run2 : $notifcationID");
    print("response.statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      isDone = ConvertInIntFromApi.fromMap(data);
      print("data : $data");
    }
  } catch (e) {
    print("e45 : $e");
  }
  return isDone!.myInt;
}
