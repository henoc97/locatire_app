

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/tenant.dart';
import '../url_admin.dart';

Future<List<Tenant>> queryAllTenats() async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryAllTenant);

  List<Tenant> myTenants = [];

  try {
    final response = await http.get(uri);
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      //print("myTenants : $myTenants");
      //print("data : ${data[0]}");
      for (var i = 0; i < data.length; i++) {
        var map = data[i];
        myTenants.add(Tenant.fromMapBDonline(map));
      }
      print("myTenants : $myTenants");
    } 
  } catch (e) {
    //print("e : $e"); 
  }
  return myTenants;
}