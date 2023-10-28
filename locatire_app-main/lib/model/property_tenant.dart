

class PropertyTenant{
  int propertyTenantID;
  int propertyID;
  int tenantID;

  PropertyTenant(this.propertyTenantID, this.propertyID, this.tenantID);

  factory PropertyTenant.fromMap(Map<String, dynamic> map) => PropertyTenant(
    map["occupantID"], 
    map["propertyID"], 
    map["tenantID"]);

  factory PropertyTenant.fromMapBDonly(var map) => PropertyTenant(
    int.parse(map["occupantID"]), 
    int.parse(map["propertyID"]), 
    int.parse(map["tenantID"]));


  Map<String, dynamic> toMap(){
    return {
      
    };
  }
}