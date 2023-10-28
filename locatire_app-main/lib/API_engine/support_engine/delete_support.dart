import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';

Future<int?> deleteSupport(String supportID) async {
  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().deleteSupport);
  ConvertInIntFromApi? isDone;
  print("run : $supportID");
  try {
    final response = await http.post(uri, body: {
      'supportID': supportID,
    });
    print("run2 : $supportID");
    print("response.statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //isDone = ConvertInIntFromApi.fromMap(data);
      print("data : $data");
    }
  } catch (e) {
    print("e45 : $e");
  }
  return 1; //isDone?.myInt;
}
