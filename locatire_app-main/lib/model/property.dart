



import '../local_data_base_engine/database_helper.dart';

class Property{
  int propertyID;
  String propertyAddress;
  String propertyDescription;
  String propertyCost;

  Property(this.propertyID, this.propertyAddress, this.propertyDescription, this.propertyCost);

  factory Property.fromMap(Map<String, dynamic> map) => Property(
    map["propertyID"], 
    map["propertyAddress"], 
    map["description"], 
    map["propertyCost"]);

    factory Property.fromMapBDonly(var map) => Property(
    int.parse(map["Id_property"]), 
    map["Address_property"], 
    map["description_property"], 
    map["Cost_property"]);


  Map<String, dynamic> toMap(){
    return {
      DatabaseHelper.propertyIDcolumn : propertyID,
      DatabaseHelper.propertyDescriptionColumn : propertyDescription,
      DatabaseHelper.propertyAddressColumn : propertyAddress,
      DatabaseHelper.propertyCostColumn : propertyCost
    };
  }
}

