import 'dart:io';
import 'dart:io';
import 'package:loginapp/Screens/Model/cart.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:loginapp/Screens/Model/cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._();
  static Database? _database;

  CartDatabaseHelper._();

  factory CartDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await openDatabase(
      // Database path and initialization options
      'your_database_name.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // Create your 'cart' table here
        await db.execute('''
       CREATE TABLE cart (
  id INTEGER PRIMARY KEY,
  product_id INTEGER,
  price REAL,
  quantity INTEGER,
  image TEXT,
  title TEXT,
  mrp REAL,
  theme TEXT,
  weight TEXT,
  vendor TEXT
);
      ''');
      },
    );

    return _database!;
  }

  Future<int> insertCartItem(CartItem item) async {
    final db = await database;
    return await db.insert('cart', item.toMap());
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<int> updateCartItem(CartItem item) async {
    final db = await database;
    return await db
        .update('cart', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> deleteCartItem(int id) async {
    final db = await database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
