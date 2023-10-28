


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/tenant.dart';
import '../url_admin.dart';

Future<Tenant?> queryTenantByID(String id) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryTenantByID);

  Tenant? myTenant;

  try {
    final response = await http.post(uri, body: {
      'tenantID' : id,
    });
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      myTenant = Tenant.fromMapBDonline(data[0]);
      print("myTenant : $data");
      //print("data : ${data[2]["Address_property"]}");
      
    } 
  } catch (e) {
    print("e22222 : $e"); 
  }
  return myTenant;
}