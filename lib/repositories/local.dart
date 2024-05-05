import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

abstract class LocalRepository<T extends BaseModel> {
  static late final Database _instance;

  String get key => '';

  toJson(T item) => throw UnimplementedError();

  fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  static Future<void> initialize() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'local.db');
    _instance = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE record ('
          'id INTEGER PRIMARY KEY,'
          'createdAt DATETIME'
          ')',
        );
        await db.execute(
          'CREATE TABLE criterion ('
          'id INTEGER PRIMARY KEY,'
          'record_id INTEGER,'
          'name TEXT,'
          'value DECIMAL,'
          'createdAt DATETIME,'
          'FOREIGN KEY (record_id) REFERENCES record(id)'
          ')',
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await db.execute(
          'CREATE TABLE temp ('
          'id INTEGER PRIMARY KEY,'
          'pcd DECIMAL,'
          'ptbd DECIMAL,'
          'weight DECIMAL,'
          'bp DECIMAL,'
          'temp DECIMAL,'
          'memo TEXT,'
          'createdAt DATETIME'
          ')',
        );
      },
    );
  }

  Future<T> createOne(T item) async {
    final id = await _instance.insert(
      key,
      toJson(item),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await _instance.execute(
      'UPDATE $key SET createdAt = datetime(\'now\') WHERE id = $id',
    );

    item.id = id;
    item.createdAt = DateTime.now();
    return item;
  }

  Future<List<T>> getMany() async {
    final List<Map<String, dynamic>> maps = await _instance.query(key);
    return List.generate(maps.length, (index) => fromJson(maps[index]));
  }

  Future<void> updateOne(T item) async {
    await _instance.update(
      key,
      toJson(item),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteOne(int id) async {
    await _instance.delete(
      key,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
