


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> registerSupport(String tenantID,String message, String dateTime, String hourseMin, String source)
  async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().insertSupport);
    ConvertInIntFromApi? isDone;
    try {
      final response = await http.post(uri, body: {
      'tenantID' : tenantID,
      'message' : message,
      'date_time' : dateTime,
      'hourse_min' : hourseMin,
      'source' : source
      
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