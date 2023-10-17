

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> insertNotification(String tenantID, String propertyID, String message, String monthPayed, String notificationDate)async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().insertNotification);
    ConvertInIntFromApi? isDone;
    
    try {
      final response = await http.post(uri, body: {
      'tenantID' : tenantID,
      'propertyID' : propertyID,
      'message' : message,
      'monthPayed' : monthPayed,
      'notificationDate' : notificationDate
    });
    print("response.statusCode : ${response.statusCode}");
    var data = jsonDecode(response.body) ;
    print(data);
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      isDone = ConvertInIntFromApi.fromMap(data);
    print("data : $data");
    } 
    
    
    } catch (e) {
      print(e); 
    }
    return isDone!.myInt;
      
      }