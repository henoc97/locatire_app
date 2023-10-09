

import '../local_data_base_engine/database_helper.dart';

class NotificationM{
  int? notificationID;
  String notifTitle;
  String notifMessage;
  DateTime notifDate;

  NotificationM(this.notificationID,this.notifTitle, this.notifMessage, this.notifDate);

  factory NotificationM.fromMap(Map<String, dynamic> map) => NotificationM(
    map['notificationID'], 
    map['notifTitle'],
    map['notifMessage'], 
    map['notifDate']
    );

  Map<String, dynamic> toMap(){
    return {
      DatabaseHelper.notificationIDcolumn:notificationID ,  
      DatabaseHelper.notifTitleColumn:notifTitle,
      DatabaseHelper.notifMessageColumn:notifMessage ,
      DatabaseHelper.notifDateColumn:notifDate
    };
  }
  }