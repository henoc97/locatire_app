

import '../local_data_base_engine/database_helper.dart';

class NotificationM{
  int? notificationID;
  int tenantID;
  int propertyID;
  String notifMessage;
  String sumPayed;
  String typeReceived;
  String monthPayed;
  String notifDate;

  NotificationM(this.notificationID,  this.tenantID, this.propertyID, this.notifMessage, this.sumPayed, this.typeReceived, this.monthPayed, this.notifDate) ;

  factory NotificationM.fromMap(Map<String, dynamic> map) => NotificationM(
    map['notificationID']?? 0, 
    map['tenantID'] ?? 0,
    int.parse(map["propertyID"]),
    map['message'], 
    map['sumPayed'],
    map['typeReceived'],
    map["monthPayed"],
    map["notificationDate"]
    );

    factory NotificationM.fromMapBDonline(var map) =>  NotificationM(
    map['notificationID'] , 
    int.parse(map['tenantID']),
    int.parse(map["propertyID"]),
    map['message'] , 
    map['sumPayed'] ,
    map['typeReceived'] ,
    map["monthPayed"],
    map["notificationDate"] 
    );


  Map<String, dynamic> toMap(){
    return {
      DatabaseHelper.notificationIDcolumn:notificationID ,  
      DatabaseHelper.notifMessageColumn:notifMessage ,
      DatabaseHelper.notifDateColumn:notifDate
    };
  }
  }