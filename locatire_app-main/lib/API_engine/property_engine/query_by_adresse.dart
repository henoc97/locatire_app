

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/property.dart';
import '../url_admin.dart';

Future<Property?> queryPropertyByAddress(String address) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryPropertyByAdress);

  Property? myProperty;

  try {
    final response = await http.post(uri, body: {
      'Address_property' : address,
    });
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      myProperty = Property.fromMapBDonly(data[0]);
      print("myProperty1 : $myProperty");
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      //
    } 
  } catch (e) {
    print("e11111 : $e"); 
  }
  return myProperty;
}