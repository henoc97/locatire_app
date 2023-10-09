


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/int_recieved_from_api.dart';
import '../url_admin.dart';



Future<int?> deleteTenant(int tenantID)
  async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().deleteTenant);
    ConvertInIntFromApi? isDone;
    print("run : $tenantID");
    try {
      final response = await http.post(uri, body: {
      'tenantID' : tenantID,
    });
    print("run2 : $tenantID");
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      //isDone = ConvertInIntFromApi.fromMap(data);
      print("data : $data");
    }
    } catch (e) {
      print("e45 : $e"); 
    }
    return 1;//isDone?.myInt;
      }