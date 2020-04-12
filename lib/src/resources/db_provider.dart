import 'dart:io';

import 'package:cartech_app/src/models/service_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DBProvider {

  // Private constructor
  DBProvider._dbProvider();
  static final DBProvider db = DBProvider._dbProvider();

  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async{
    String documentsDirectory = await getDatabasesPath();
    developer.log("database_path: " + join(documentsDirectory, "local_cartech.db"));
    return await openDatabase(join(documentsDirectory, "local_cartech.db"), onCreate: _onCreateDB, version: 3);
  }

  _onCreateDB(db, version){
    db.execute("CREATE TABLE service_category (service_category_id INTERGER PRIMARY KEY, service_category TEXT, createdAt DEFAULT CURRENT_TIMESTAMP)");
    return db.execute("CREATE TABLE service (service_id INTEGER PRIMARY KEY, service_name TEXT, service_category_id INTEGER, createdAt DEFAULT CURRENT_TIMESTAMP)");
  }

  Future<int> createService(Service service) async{
    final db = await database;
    final res = await db.insert("service", service.toJson());

    return res;
  }

  Future<int> createServiceCategory(ServiceCategory category) async {
    final db = await database;
    final res = await db.insert("service_category", category.toJson());
    
    return res;
  }
  
  Future<int> deleteAllServiceCategories() async{
    final db = await database;
    final res = await db.rawDelete("DELETE FROM service_category");
    
    return res;
  }

  Future<int> deleteAllServices() async{
    final db = await database;
    final res = await db.rawDelete("DELETE FROM service");

    return res;
  }

  Future<DateTime> getServiceUpdateDate(int categoryID) async{
    final db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery("SELECT createdAt FROM service WHERE service_category_id = $categoryID LIMIT 1");
    if(res.length == 0){
      return null;
    }

    DateTime dateTime = DateTime.parse(res[0]["createdAt"].toString());

    return dateTime;
  }

  Future<DateTime> getCategoryUpdateDate() async{
    final db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery("SELECT createdAt FROM service_category LIMIT 1");
    if(res.length == 0){
      return null;
    }

    developer.log("createdAt: " + res[0]["createdAt"].toString());
    DateTime dateTime = DateTime.parse(res[0]["createdAt"].toString());

    return dateTime;
  }
  
  Future<List<ServiceCategory>> getCategories() async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM service_category");
    
    List<ServiceCategory> categories = res.isNotEmpty ? res.map( (c) => ServiceCategory.fromJson(c)).toList() : [];
    
    return categories;
  }

  Future<List<Service>> getServicesFromCategory(int categoryID) async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM service WHERE service_category_id = $categoryID").catchError( (error){
      return error;
    });

    List<Service> services = res.isNotEmpty ? res.map( (c) => Service.fromJson(c)).toList() : [];

    return services;
  }

  Future<int> dropTabes() async{
    final db = await database;
    final res = await db.rawQuery("DROP TABLE service_category").catchError( (error){
      return error;
    });
  }

}