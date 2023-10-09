
import '../local_data_base_engine/database_helper.dart';

class SupportClientM{
  int? supportID;
  int tenantID;
  String message;
  int readMessage;

  SupportClientM(this.supportID, this.tenantID, this.message, this.readMessage);

  factory SupportClientM.fromMap(Map<String, dynamic> map)=> SupportClientM(
    map["supportID"], 
    map["tenantID"], 
    map["message"],
    map["readMessage"]);

  Map <String, dynamic> toMap(){
    return {
      DatabaseHelper.supportIDcolumn: supportID,  
      DatabaseHelper.tenantIDcolumn: tenantID,
      DatabaseHelper.messageColumn: message , 
      DatabaseHelper.readMessageColumn: readMessage
    };
  }
}