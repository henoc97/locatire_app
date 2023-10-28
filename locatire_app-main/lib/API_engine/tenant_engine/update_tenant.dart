


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';

Future<int?> updateTenant(String tenantID, String tenantName, String tenantLastName,String tenantContact1, String tenantContact2, String inscriptionTenantDate)async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().updateTenant);
    ConvertInIntFromApi? isDone;
    try {
      final response = await http.post(uri, body: {
      "tenantID" : tenantID,
      'tenantName' : tenantName,
      'tenantLastName' : tenantLastName,
      'tenantContact1' : tenantContact1, 
      'tenantContact2' : tenantContact2,
      "inscriptionTenantDate" : inscriptionTenantDate,
    });
    print(tenantID);
    print("response.statusCode : ${response.statusCode}");
    var data = jsonDecode(response.body) ;
    print("data : $data");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      isDone = ConvertInIntFromApi.fromMap(data);
      
    } 
    } catch (e) {
      //print(e); 
    }
    print(isDone?.myInt); 
    return isDone?.myInt;
      }