
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/post_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final String tablePost = 'tablePost';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnColor = 'color';
  final String columnYear = 'year';
  final String columnPantoneValue = 'pantone_value';
  /**
      required this.id,
      required this.name,
      required this.color,
      required this.year,
      required this.pantone_value,
   * */


  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'post_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tablePost (
            $columnId INTEGER NOT NULL,
            $columnName TEXT NOT NULL,
            $columnColor TEXT NOT NULL,
            $columnYear INTEGER NOT NULL,
            $columnPantoneValue TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertPost(PostModel post) async {
    final db = await database;
    return await db.insert(tablePost, post.toJson());
  }

  Future<List<PostModel>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tablePost);

    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }

  Future<int> deletePost(int id) async {
    final db = await database;
    return await db.delete(
      tablePost,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Close the database
  Future close() async {
    final db = await database;
    db.close();
  }
}
