import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';

Future<int?> deleteReceived(String receivedID) async {
  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().deleteReceived);
  ConvertInIntFromApi? isDone;
  try {
    final response = await http.post(uri, body: {
      'Id_received': receivedID,
      'isViewedByTenant': "0",
      'isViewedByOwner': "1",
    });
    print("response.statusCode1 : ${response.statusCode}");
    var data = jsonDecode(response.body);
    print("data : $data");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("data : $data");
      isDone = ConvertInIntFromApi.fromMap(data);
      print("data : $data");
    }
  } catch (e) {
    print("ehuhhhe : $e");
  }
  return isDone?.myInt;
}
