

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/property.dart';
import '../url_admin.dart';

Future<Property?> queryPropertyByID(String id) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryPropertyByID);

  Property? myProperty;

  try {
    final response = await http.post(uri, body: {
      'propertyID' : id,
    });
    print("id : ${id}");
    print("response.statusCod11e : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      print("myProperty1 : $data");
      myProperty = Property.fromMapBDonly(data[0]);
      //print("myProperty1 : $myProperty");
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      //
    } 
  } catch (e) {
    print("e11111 : $e"); 
  }
  return myProperty;
}