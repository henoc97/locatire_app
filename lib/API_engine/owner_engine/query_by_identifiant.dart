


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/owner.dart';
import '../url_admin.dart';

Future<Owner?> queryOwnerByIdentifiant(String identifiant) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryPropertyByID);

  Owner? myOwner;

  try {
    final response = await http.post(uri, body: {
      'identifiant' : identifiant,
    });
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      myOwner = Owner.fromMapBDonline(data[0]);
      //print("myProperty1 : $myProperty");
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      //
    } 
  } catch (e) {
    print("e11111 : $e"); 
  }
  return myOwner;
}