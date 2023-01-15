import '../utils/static_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> hijridatabase() async {
    final dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, 'hijri.db');
    return openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        var userEventsTable = 'user_events_tbl';
        var publicEventsTable = 'public_events_tbl';
        await db
            .execute(
                'CREATE Table $userEventsTable (id TEXT PRIMARY KEY , title nvarchr(20), event_day INTEGER not null, event_month INTEGER not null, event_year INTEGER not null, is_notified INTEGER not null)')
            .then((value) => print('table $userEventsTable created'));
        await db
            .execute(
                'CREATE Table $publicEventsTable (id TEXT PRIMARY KEY , title nvarchr(20), event_day INTEGER not null, event_month INTEGER not null, event_year INTEGER not null)')
            .then((value) => print('table $publicEventsTable created'));

        publicEventsEn.forEach((element) {
          db
              .insert(publicEventsTable, element,
                  conflictAlgorithm: ConflictAlgorithm.replace)
              .then(
                  (value) => print('Public Events Data inserted succesfully'));
        });
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.hijridatabase();
    db
        .insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => print('Record $value Inserted Successfully'));
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DBHelper.hijridatabase();
    return db.query(table);
  }

  static Future<void> delete(String table, String? id) async {
    final db = await DBHelper.hijridatabase();
    return db.delete(table, where: 'id = ?', whereArgs: [id]).then(
        (value) => print('Record $id Deleted Successfully'));
  }

  static Future<void> update(
      String table, Map<String, Object> data, String? id) async {
    final db = await DBHelper.hijridatabase();
    db
        .update(table, data,
            where: 'id = ?',
            whereArgs: [id],
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => print('Record $value updated Successfully'));
  }
}
