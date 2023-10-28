

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> linkPropertyTenant(String propertyID,String tenantID)async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().linkPropertyTenant);
    ConvertInIntFromApi? isDone;
    
    try {
      final response = await http.post(uri, body: {
      'propertyID' : propertyID,
      'tenantID' : tenantID,
    });
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      isDone = ConvertInIntFromApi.fromMap(data);
    //print("data : $data");
    } 
    
    
    } catch (e) {
      print(e); 
    }
    return isDone!.myInt;
      
      }