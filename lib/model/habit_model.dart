class HabitModel {
  final String? name;
  final DateTime? startedAt;
  int timeSpent;
  int timeGoal;
  bool habitStarted;
  final String? durationString;
  final Duration? duration;
  final String? description;
  HabitModel({
    this.name,
    this.description,
    required this.timeSpent,
    required this.timeGoal,
    this.startedAt,
    this.duration,
    this.durationString,
    this.habitStarted = false,
  });
}
