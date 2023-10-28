
import '../local_data_base_engine/database_helper.dart';

class SupportClientM{
  int supportID;
  String tenantID;
  String message;
  String dateTime;
  String hourseMin;
  String source;

  SupportClientM(this.supportID, this.tenantID, this.message, this.dateTime, this.hourseMin, this.source);

  factory SupportClientM.fromMap(Map<String, dynamic> map)=> SupportClientM(
    int.parse(map["supportID"]), 
    map["tenantID"], 
    map["message"],
    map["date_time"],
    map["hourse_min"],
    map["source"],);

    factory SupportClientM.fromMapDBonline(var map)=> SupportClientM(
    int.parse(map["Id_support"]),  // Handle null values by providing a default value
    map["Id_tenant"],  // Provide default empty string for null values
    map["message"] ,
    map["date_time"],
    map["hourse_min"],
    map["source"] ?? '',
  );


  Map <String, dynamic> toMap(){
    return {
      DatabaseHelper.supportIDcolumn: supportID,  
      DatabaseHelper.tenantIDcolumn: tenantID,
      DatabaseHelper.messageColumn: message , 
      //DatabaseHelper.readMessageColumn: readMessage
    };
  }
}