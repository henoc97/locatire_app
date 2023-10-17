
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/received.dart';
import '../url_admin.dart';

Future<List<Received>> queryAllReceivedpayedByTenantID(String idTenant, String idProperty) async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryAllReceivedpayedByTenantID);

  List<Received> myReceived = [];

  
    final response = await http.post(uri, body: {
      'tenantID' : idTenant,
      "propertyID" : idProperty,
    });
    print("response.statusCode : ${response.statusCode}");
    
      
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      print("Receivedpayed : $data");
      //print("data : ${data[2]["Address_property"]}");
      for (var i = 0; i < data.length; i++) {
        var map = data[i];
        myReceived.add(Received.fromMapDBonline(map));
      }
      //print("Receivedpayed : $myProperties");
    } 
  
  return myReceived;
}