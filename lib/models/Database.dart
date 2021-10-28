import 'package:mongo_dart/mongo_dart.dart';
import 'dart:core';

class Database {
  static Database? instance;
  final String _database = "Mealeon";
  final String _username = "ludde";
  final String _password = "Smulan98";
  String connectString = "";
  late Db db;

  Database() {
    connectString = 'mongodb+srv://$_username:$_password@mealeon.uzfux.mongodb.net/$_database?retryWrites=true&w=majority';
  }

  static getInstance() {
    if(instance == null) {
      instance = Database();
    }
    return instance;
  }

  Future<Db> connect() async {
    try {
      db = await Db.create(connectString);
      if(!db.isConnected) {
        await db.open();
      }
    } catch(e) {
      print("Error: $e");
    }
    return db;
  }

  close() {
    db.close();
  }

  void printMeals() async {
    var meals = db.collection('meals');
    await meals.find(where.sortBy('name')).forEach((meal) {
      print(meal);
    });
  }
}