


import '../local_data_base_engine/database_helper.dart';

class Received{
  int receivedID;
  int tenantID;
  int propertyID;
  String sumPayed;
  String monthPayed;
  String typeReceived;
  String dateReceived;

  Received(this.receivedID, this.tenantID, this.propertyID, this.sumPayed, this.monthPayed, this.typeReceived, this.dateReceived);

  factory Received.fromMap(Map<String, dynamic> map)=>Received(
    map["receivedID"], 
    map["tenantID"], 
    map["propertyID"], 
    map["sumPayed"],
    map["monthPayed"],
    map["typeReceived"],
    map["dateReceived"]
    );

    factory Received.fromMapDBonline(var map)=>Received(
    int.parse(map["Id_received"]), 
    int.parse(map["Id_tenant"]), 
    int.parse(map["Id_property"]), 
    map["sumPayed"],
    map["monthPayed"],
    map["Type_received"],
    map["Date_received"]
    );


  Map<String, dynamic> toMap(){
    return {
      DatabaseHelper.receivedIDcolumn : receivedID ,  
      DatabaseHelper.tenantIDcolumn : tenantID,
      DatabaseHelper.propertyIDcolumn : propertyID,
      DatabaseHelper.typeReceivedColumn : typeReceived,
      DatabaseHelper.dateReceivedColumn :  dateReceived
    };
  }
}
