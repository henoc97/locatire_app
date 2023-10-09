
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/received.dart';
import '../url_admin.dart';

Future<List<Received>> queryAllReceivedpayed() async{

  Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().queryAllReceived);

  List<Received> myReceived = [];

  try {
    final response = await http.get(uri);
    //print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      //print("myProperties : $myProperties");
      //print("data : ${data[2]["Address_property"]}");
      for (var i = 0; i < data.length; i++) {
        var map = data[i];
        myReceived.add(Received.fromMapDBonline(map));
      }
      //print("myProperties : $myProperties");
    } 
  } catch (e) {
    print("e1 : $e"); 
  }
  return myReceived;
}