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
    final path = join(databasePath, 'temp2.db');
    _instance = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE temp ('
          'id INTEGER PRIMARY KEY,'
          'pcd DECIMAL,'
          'ptbd DECIMAL,'
          'weight DECIMAL,'
          'bpMax DECIMAL,'
          'bpMin DECIMAL,'
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

    item.id = id;
    return item;
  }

  Future<T> getOne({required int id}) async {
    final List<Map<String, dynamic>> maps =
        await _instance.query(key, where: 'id = $id');
    return fromJson(maps[0]);
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
