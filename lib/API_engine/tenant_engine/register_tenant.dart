


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> registerTenant(
  String tenantName,String tenantLastName, String tenantContact1, 
  String tenantContact2, inscriptionTenantDate)
  async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().registerTenat);
    ConvertInIntFromApi? isDone;
    try {
      final response = await http.post(uri, body: {
      'tenantName' : tenantName,
      'tenantLastName' : tenantLastName,
      'tenantContact1' : tenantContact1, 
      'tenantContact2' : tenantContact2,
      "inscriptionTenantDate" : inscriptionTenantDate,
    });
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      isDone = ConvertInIntFromApi.fromMap(data);
      //print("data : $data");
    } 
    } catch (e) {
      print(e); 
    }
    return isDone?.myInt;
      }