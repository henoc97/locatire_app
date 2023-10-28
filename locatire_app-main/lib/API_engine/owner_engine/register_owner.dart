
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../url_admin.dart';



Future<int> registerOwner(String identifiant,String ownerConctactMoov, String ownerConctactTmoney, String pwd)async{
    Uri uri = Uri.parse(UrlAdmin().serverUrl + UrlAdmin().registerOwner);
    int isDone = -1;
    try {
      final response = await http.post(uri, body: {
      'identifiant' : identifiant,
      'ownerConctactMoov' : ownerConctactMoov,
      'ownerConctactTmoney' : ownerConctactTmoney, 
      'pwd' : pwd
    });
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode==200){
      var data = jsonDecode(response.body) ;
      if (data["message"]=="insertion succeeded") {
        isDone = 1;
        //print("data1 = $data");
      }else{
        isDone=0;
        //print("data5 = $data");
      }
    } 
    } catch (e) {
      //print(e); 
    }
    return isDone;
      }