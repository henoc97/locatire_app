

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/property_tenant.dart';
import '../url_admin.dart';

Future<List<PropertyTenant>> queryAllPropertyTenant() async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryAllPrpertyTenant);

  List<PropertyTenant> myPropertyTenant = [];

  try {
    final response = await http.get(uri);
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      for (var i = 0; i < data.length; i++) {
        var map = data[i];
        myPropertyTenant.add(PropertyTenant.fromMapBDonly(map));
      }
     // print("myPropertyTenant : $myPropertyTenant");
    } 
  } catch (e) {
    print("exp1 : $e"); 
  }
  return myPropertyTenant;
}