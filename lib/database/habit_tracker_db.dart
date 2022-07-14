import 'package:habit_tracker/model/habit_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class HabitTrackerDB {
  static Database? _db;
  static const String TABLE = 'habit_tracker';
  static const String DB_NAME = 'habit.db';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String DATE = 'startedAt';
  static const String TIMESPENT = 'timeSpent';
  static const String TIMEGOAL = 'timeGoal';
  static const String SHOULDSTART = 'shouldStart';

  static Future<Database?> get _habitDatabase async {
    _db = await _initializeDatabase();
    return _db;
  }

  static Future<Database?> _initializeDatabase() async {
    final directory = await getDatabasesPath();
    final path = p.join(directory, DB_NAME);
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static _createDatabase(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $DATE TEXT, $TIMEGOAL INTEGER, $TIMESPENT INTEGER, $SHOULDSTART BOOLEAN)''');
  }

  static Future<int> saveHabit(HabitModel model) async {
    var dbClient = await _habitDatabase;
    model.id = await dbClient!.insert(TABLE, model.toMap());
    return model.id!;
  }

  static Future<List<HabitModel>> getHabitList() async {
    var dbClient = await _habitDatabase;
    List<Map<String, dynamic>> map = await dbClient!.query(
      TABLE,
      columns: [ID, NAME, DATE, TIMEGOAL, TIMESPENT, SHOULDSTART],
    );
    List<HabitModel> model = [];
    for (var i = 0; i < map.length; i++) {
      model.add(HabitModel.fromMap(map[i]));
    }
    model.sort((a, b) => b.startedAt!.compareTo(a.startedAt!));
    return model;
  }

  static Future<int> deleteHabit(int id) async {
    var dbClient = await _habitDatabase;
    return dbClient!.delete(
      TABLE,
      where: '$ID = ?',
      whereArgs: [id],
    );
  }
}
