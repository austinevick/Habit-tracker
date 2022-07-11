// class HabitTrackerDB{
//   static Database? _db;
//   static const String TABLE = 'word';
//   static const String DB_NAME = 'word.db';
//   static const String ID = 'id';
//   static const String WORD = 'word';
//   static const String DATE = 'dateTime';

//   static Future<Database?> get wordDB async {
//     _db = await initDB();
//     return _db;
//   }

//   static Future<Database?> initDB() async {
//     final directory = await getDatabasesPath();
//     final path = p.join(directory, DB_NAME);
//     return openDatabase(path, version: 1, onCreate: createDatabase);
//   }

//   static createDatabase(Database db, int version) async {
//     await db.execute(
//         '''CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $WORD TEXT, $DATE TEXT)''');
//   }

//   static Future<WordHistoryModel> saveWord(WordHistoryModel model) async {
//     var dbClient = await wordDB;
//     model.id = await dbClient!.insert(TABLE, model.toMap());
//     return model;
//   }

//   static Future<List<WordHistoryModel>> getWordHistory() async {
//     var dbClient = await wordDB;
//     List<Map<String, dynamic>> map = await dbClient!.query(
//       TABLE,
//       columns: [ID, WORD, DATE],
//     );
//     List<WordHistoryModel> model = [];
//     for (var i = 0; i < map.length; i++) {
//       model.add(WordHistoryModel.fromMap(map[i]));
//     }
//     model.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
//     return model;
//   }

//   static Future<int> deleteWord(int id) async {
//     var dbClient = await wordDB;
//     return dbClient!.delete(
//       TABLE,
//       where: '$ID = ?',
//       whereArgs: [id],
//     );
//   }
 
// }