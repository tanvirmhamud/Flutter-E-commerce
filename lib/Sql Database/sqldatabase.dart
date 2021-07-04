import 'dart:io';

import 'package:flutter_shopping_1/Sql%20Database/productsqlmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Sqldbprovider {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductDB.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute("""
       CREATE TABLE MYTable (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name TEXT,
       details TEXT,
       price DOUBLE,
       image TEXT,
       orderno INTEGER,
       productno INTEGER
      )

      """);
    });
  }

  Future<bool> insertdata(ProductModel productModel) async {
    final db = await initdb();
    db.insert("MYTable", productModel.toMap());
    return true;
  }

  Future<List<ProductModel>> getdata() async {
    final db = await initdb();
    final List<Map<String, Object?>> datas = await db.query("MYTable");
    return datas.map((e) => ProductModel.fromMap(e)).toList();
  }

  update(ProductModel product) async {
    final db = await initdb();
    var result = await db.update("MYTable", product.toMap(),
        where: "id = ?", whereArgs: [product.id]);
    return result;
  }

  orderupdate(ProductModel product) async {
    final db = await initdb();
    var result = await db.update("MYTable", product.toMap(),
        where: "id = ?", whereArgs: [product.orderno]);
    return result;
  }

  Future delete(int id) async {
    final db = await initdb();
    db.delete("MYTable", where: "id = ?", whereArgs: [id]);
  }
}
