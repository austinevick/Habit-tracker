import 'package:habit_tracker/database/habit_tracker_db.dart';
import 'package:habit_tracker/model/habit_model.dart';

class HabitTrackerProvider {
  static Future<int> saveHabit(HabitModel model) async {
    return await HabitTrackerDB.saveHabit(model);
  }

  static Future<List<HabitModel>> getHabitList() async {
    return await HabitTrackerDB.getHabitList();
  }

  static Future<int> deleteHabit(int id) async {
    return await HabitTrackerDB.deleteHabit(id);
  }
}
