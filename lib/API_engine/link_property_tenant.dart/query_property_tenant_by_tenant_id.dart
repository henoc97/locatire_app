




import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:locataireapp/model/property_tenant.dart';

import '../url_admin.dart';

Future<PropertyTenant?> queryPropertyTenantByTenantID(int id) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryPropertyTenantByTenantID);

  PropertyTenant? myPropertyTenant;
    print("ok");
  try {
    final response = await http.post(uri, body: {
      'tenantID' : id.toString(),
    });
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      myPropertyTenant = PropertyTenant.fromMapBDonly(data[0]);
      print("myTenant11 : $data");
      //print("data : ${data[2]["Address_property"]}");
    } 
  } catch (e) {
    print("e22222 : $e"); 
  }
  return myPropertyTenant;
}