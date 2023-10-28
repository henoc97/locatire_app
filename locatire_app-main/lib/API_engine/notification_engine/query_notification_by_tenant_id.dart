import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:locataireapp/model/notification.dart';

import '../url_admin.dart';

Future<List<NotificationM>> queryAllNotificationByTenantID(
    String idTenant) async {
  Uri uri = Uri.parse(
      UrlAdmin().serverUrl + UrlAdmin().queryAllNotificationByTenantID);

  List<NotificationM> myNotification = [];

  final response = await http.post(uri, body: {
    'tenantID': idTenant,
  });
  print("response.statusCode : ${response.statusCode}");

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("myNotification : $data");
      //print("data : ${data[2]["Address_property"]}");
      for (var i = 0; i < data.length; i++) {
        var map = data[i];
        myNotification.add(NotificationM.fromMapBDonline(map));
      }
      //print("Receivedpayed : $myProperties");
    }
  } catch (e) {
    print(e);
  }

  return myNotification;
}
