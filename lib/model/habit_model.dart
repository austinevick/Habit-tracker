class HabitModel {
  final String? name;
  final DateTime? startedAt;
  int timeSpent;
  int timeGoal;
  bool habitStarted;
  final String? durationString;
  final Duration? duration;
  HabitModel({
    this.name,
    required this.timeSpent,
    required this.timeGoal,
    this.startedAt,
    this.duration,
    this.durationString,
    this.habitStarted = false,
  });
}

final habits = <HabitModel>[];
