


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:locataireapp/model/support_client.dart';

import '../url_admin.dart';

Future<List<SupportClientM>> queryAllSupportClientM(String id) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryAllSupportByTenantID);

  List<SupportClientM> mySupportClientM= [];

  try {
    final response = await http.post(uri, body: {
      'tenantID' : id,
    });
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      print("map : $data");
      print("data.length : ${data.length}");
      
      for (var i = 0; i < data.length; i++) {
        print(i);
        var map = data[i];
        print("map : $map");
        mySupportClientM.add(SupportClientM.fromMapDBonline(data[i]));
      }
      print("mySupportClientM : $mySupportClientM");
    } 
  } catch (e) {
    print("e1 : $e"); 
  }
  return mySupportClientM;
}