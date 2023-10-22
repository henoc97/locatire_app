

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> insertNotification(String tenantID, String propertyID, String message, String sumPayed, String typeReceived, String monthPayed, String notificationDate)async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().insertNotification);
    ConvertInIntFromApi? isDone;
    
    try {
      final response = await http.post(uri, body: {
      'tenantID' : tenantID,
      'propertyID' : propertyID,
      'message' : message,
      'sumPayed' : sumPayed,
      'typeReceived' : typeReceived,
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