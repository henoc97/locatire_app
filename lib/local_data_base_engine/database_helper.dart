
// ignore_for_file: depend_on_referenced_packages


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notification.dart';
import '../model/owner.dart';
import '../model/property.dart';
import '../model/property_tenant.dart';
import '../model/received.dart';
import '../model/support_client.dart';
import '../model/tenant.dart';



class DatabaseHelper{
  static const _databaseName = "essaie_data_base";
  static  const int _version=1;


  //Owner table
  static String ownerTable = "owner";
  static const ownerIDcolumn = "ownerID";
  static const identifiantColumn = "identifiant";
  static const ownerConctactMoovColumn = "ownerConctactMoov";
  static const ownerConctactTmoneyColumn = "ownerConctactTmoney";
  static const pwdColumn = "pwd";


  //Tenant table
  static String tenantTable ="tenant";
  static const tenantIDcolumn ="tenantId";
  static const tenantNameColumn = "tenantName";
  static const tenantLastNameColumn = 'tenantLastName';
  static const tenantContact1Column = "tenantContact1";
  static const tenantContact2Column = "tenantContact2";


  //Property table
  static String propertyTable="property";
  static const propertyIDcolumn = "propertyID";
  static const propertyAddressColumn ='propertyAddress';
  static const propertyDescriptionColumn='propertyDescription' ;
  static const propertyCostColumn = "propertyCost";

  // PropertyTenant table
  static String propertyTenantTable = "propertyTenant";
  static const propertyTenantIDcolumn = "propertyTenantID" ;



  //Received table
  static String receivedTable = "Received";
  static const receivedIDcolumn = "receivedID";
  static const typeReceivedColumn = "typeReceived";
  static const dateReceivedColumn = "dateReceived";

  //SupportClient table
  static String supportTable = "SupportClient";
  static const supportIDcolumn ="supportID";
  static const messageColumn = "message";
  static const readMessageColumn = "readMessage";

  //Notification table
  static String notifiicationTable = "Notification";
  static const notificationIDcolumn = "notificationID";
  static const notifTitleColumn = "notifTitle";
  static const notifMessageColumn = "notifMessage";
  static const notifDateColumn = "notifDate";



  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor(); 


  static Database? _database;
  //getter for database
  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
    path,
    version: _version,
    onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $ownerTable (
    $ownerIDcolumn INT NOT NULL AUTO_INCREMENT ,
    $identifiantColumn VARCHAR(50),
    $ownerConctactMoovColumn VARCHAR(20),
    $ownerConctactTmoneyColumn VARCHAR(20)
    $pwdColumn VARCHAR(50),
    PRIMARY KEY($ownerIDcolumn)
  );

  CREATE TABLE $tenantTable (
    $tenantIDcolumn INT NOT NULL AUTO_INCREMENT ,
    $tenantNameColumn VARCHAR(20),
    $tenantLastNameColumn VARCHAR(50),
    $tenantContact1Column VARCHAR(20),
    $tenantContact2Column VARCHAR(20),
    PRIMARY KEY($tenantIDcolumn)
  );

  CREATE TABLE $propertyTable (
    $propertyIDcolumn INT NOT NULL AUTO_INCREMENT ,
    $propertyAddressColumn VARCHAR(50),
    $propertyDescriptionColumn VARCHAR(150),
    $propertyCostColumn INT,
    PRIMARY KEY($propertyIDcolumn)
  );

  CREATE TABLE $propertyTenantTable(
    $propertyTenantIDcolumn INT NOT NULL AUTO_INCREMENT ,
    $propertyIDcolumn INT REFERENCES propertyTable ($propertyIDcolumn ),
    $tenantIDcolumn INT REFERENCES tenantTable ($tenantIDcolumn ) ON DELETE CASCADE,
  )

  CREATE TABLE $receivedTable (
    $receivedIDcolumn INT NOT NULL AUTO_INCREMENT,
    $typeReceivedColumn VARCHAR(25),
    $dateReceivedColumn VARCHAR(25),
    FOREIGN KEY ($tenantIDcolumn) REFERENCE $tenantTable($tenantIDcolumn),
    FOREIGN KEY ($propertyIDcolumn) REFERENCE $propertyTable($propertyIDcolumn),
    PRIMARY KEY ($receivedIDcolumn)
  );

  CREATE TABLE $supportTable (
    $supportIDcolumn INT NOT NULL AUTO_INCREMENT,
    $messageColumn TEXT,
    $readMessageColumn BOOLEAN,
    FOREIGN KEY ($tenantIDcolumn) REFERENCE $tenantTable($tenantIDcolumn),
    PRIMARY KEY($supportIDcolumn)
  );

  CREATE TABLE $notifiicationTable (
    $notificationIDcolumn INT NOT NULL AUTO_INCREMENT,
    $notifTitleColumn VARCHAR(30),
    $notifMessageColumn VARCHAR(40),
    $notifDateColumn VARCHAR(30),
    PRIMARY KEY($notificationIDcolumn)
  );
  ''');}

  //  insertions
  Future<int> insertOwner(Owner owner) async {
    Database db = await instance.database;
    return await db.insert(ownerTable, owner.toMap());
  }

  Future<int> insertTenant(Tenant tenant) async {
    Database db = await instance.database;
    return await db.insert(tenantTable, tenant.toMap());
  }

  Future<int> insertProperty(Property property) async {
    Database db = await instance.database;
    return await db.insert(propertyTable, property.toMap());
  }

  Future<int> insertPropertyTenant(PropertyTenant propertyTenant) async {
    Database db = await instance.database;
    return await db.insert(propertyTable, propertyTenant.toMap());
  }

  Future<int> insertReceived(Received received) async {
    Database db = await instance.database;
    return await db.insert(receivedTable, received.toMap());
  }

  Future<int> insertSupportClient(SupportClientM supportClient) async {
    Database db = await instance.database;
    return await db.insert(supportTable, supportClient.toMap());
  }

  Future<int> insertNotification(NotificationM notification) async {
    Database db = await instance.database;
    return await db.insert(supportTable, notification.toMap());
  }

  // QueryAllRows
  Future<List<Map<String, dynamic>>> queryAllRowsTenant() async {
    Database db = await instance.database;
    return await db.query(tenantTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsPropertyTenant() async {
    Database db = await instance.database;
    return await db.query(propertyTenantTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsProperty() async {
    Database db = await instance.database;
    return await db.query(propertyTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsReceived() async {
    Database db = await instance.database;
    return await db.query(receivedTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsSupport() async {
    Database db = await instance.database;
    return await db.query(supportTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsNotification() async {
    Database db = await instance.database;
    return await db.query(notifiicationTable);
  }


  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryTenantbyID(id) async {
    Database db = await instance.database;
    return await db.query(tenantTable, where: "$tenantIDcolumn LIKE '%$id'");
  }

  Future<List<Map<String, dynamic>>> queryTenantbyName(tenantName) async {
    Database db = await instance.database;
    return await db.query(tenantTable, where: "$tenantLastNameColumn LIKE '%$tenantName'");
  }

  Future<List<Map<String, dynamic>>> queryProperty(id) async {
    Database db = await instance.database;
    return await db.query(propertyTable, where: "$propertyIDcolumn LIKE '%$id'");
  }

  Future<List<Map<String, dynamic>>> queryReceivedbyDate(receivedDate) async {
    Database db = await instance.database;
    return await db.query(receivedTable, where: "$receivedIDcolumn LIKE '%$receivedDate'");
  }

  // updates

  Future<int> updateOwner(Owner owner) async {
    Database db = await instance.database;
    int id = owner.toMap()[ownerIDcolumn];
    return await db.update(ownerTable, owner.toMap(), where: '$ownerIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> updateTenant(Tenant tenant) async {
    Database db = await instance.database;
    int id = tenant.toMap()[tenantIDcolumn];
    return await db.update(tenantTable, tenant.toMap(), where: '$tenantIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> updateProperty(Property property) async {
    Database db = await instance.database;
    int id = property.toMap()[propertyIDcolumn];
    return await db.update(propertyTable, property.toMap(), where: '$propertyIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> updatePropertyTenant(PropertyTenant propertyTenant) async {
    Database db = await instance.database;
    int id = propertyTenant.toMap()[propertyTenantIDcolumn];
    return await db.update(propertyTenantTable, propertyTenant.toMap(), where: '$propertyTenantIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> updateReceived(Received received) async {
    Database db = await instance.database;
    int id = received.toMap()[receivedIDcolumn];
    return await db.update(receivedTable, received.toMap(), where: '$receivedIDcolumn = ?', whereArgs: [id]);
  }

  // deletes
  Future<int> deleteTenant(Tenant tenant) async {
    Database db = await instance.database;
    int id = tenant.toMap()[tenantIDcolumn];
    return await db.delete(tenantTable, where: '$tenantIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> deleteProperty(Property property) async {
    Database db = await instance.database;
    int id = property.toMap()[propertyIDcolumn];
    return await db.delete(propertyTable, where: '$propertyIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> deletePropertyTenant(PropertyTenant propertyTenant) async {
    Database db = await instance.database;
    int id = propertyTenant.toMap()[propertyTenantIDcolumn];
    return await db.delete(propertyTenantTable, where: '$propertyTenantIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> deleteReceived(Received received) async {
    Database db = await instance.database;
    int id = received.toMap()[receivedIDcolumn];
    return await db.delete(receivedTable, where: '$receivedIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> deleteSupport(SupportClientM supportClient) async {
    Database db = await instance.database;
    int id = supportClient.toMap()[supportIDcolumn];
    return await db.delete(supportTable, where: '$supportIDcolumn = ?', whereArgs: [id]);
  }

  Future<int> deleteNotification(NotificationM notification) async {
    Database db = await instance.database;
    int id = notification.toMap()[notificationIDcolumn];
    return await db.delete(notifiicationTable, where: '$supportIDcolumn = ?', whereArgs: [id]);
  }

}