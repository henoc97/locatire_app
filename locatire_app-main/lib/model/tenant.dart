


import '../local_data_base_engine/database_helper.dart';

class Tenant{
  int tenantID; 
  String tenantName;
  String tenantLastName;
  String tenantContact1;
  String tenantContact2;
  String inscriptionTenantDate;
  

  Tenant(
    this.tenantID, 
    this.tenantName, 
    this.tenantLastName, 
    this.tenantContact1, 
    this.tenantContact2,
    this.inscriptionTenantDate
    );

    factory Tenant.fromMap(var map) => Tenant(
      int.parse(map["tenantID"]) , 
      map["tenantName"], 
      map["tenantLastName"], 
      map["tenantContact1"], 
      map["tenantContact2"],
      map["inscriptionTenantDate"]
      );

      factory Tenant.fromMapBDonline(var map) => Tenant(
      int.parse(map["Id_tenant"]) , 
      map["Name_tenant"], 
      map["Last_name_tenant"], 
      map["Contact1"], 
      map["Contact2"],
      map["inscriptionTenantDate"]
      );


    Map<String, dynamic> toMap(){
      return {
        DatabaseHelper.tenantIDcolumn : tenantID,
        DatabaseHelper.tenantNameColumn  : tenantName ,
        DatabaseHelper.tenantLastNameColumn : tenantLastName ,
        DatabaseHelper.tenantContact1Column : tenantContact1 ,
        DatabaseHelper.tenantContact2Column : tenantContact2
        //inscriptionTenantDate a ajouter 
      }; 
    }
}