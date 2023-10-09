


import '../local_data_base_engine/database_helper.dart';

class Owner{
  int ownerID;
  String identifiant;
  String ownerConctactMoov;
  String ownerConctactTmoney;
  String pwd;

  Owner(this.ownerID, this.identifiant, this.ownerConctactMoov, this.ownerConctactTmoney, this.pwd);

  factory Owner.fromMap(Map<String, dynamic> map) => Owner(
    int.parse(map["ownerID"]),
    map['identifiant'],
    map['ownerContactMoov'],
    map['ownerContactTmoney'],
    map["pwd"]
  );

  factory Owner.fromMapBDonline(var map) => Owner(
    int.parse(map["ownerID"]),
    map['identifiant'],
    map['ownerConctactMoov'],
    map['ownerConctactTmoney'],
    map["pwd"]
  );

  Map<String, dynamic> toMap(){
    return {
      DatabaseHelper.ownerIDcolumn : ownerID,
      DatabaseHelper.identifiantColumn : identifiant,
      DatabaseHelper.ownerConctactMoovColumn : ownerConctactMoov,
      DatabaseHelper.ownerConctactTmoneyColumn : ownerConctactTmoney,
      DatabaseHelper.pwdColumn : pwd
    };
  }
}