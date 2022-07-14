class HabitModel {
  final String? name;
  final DateTime? startedAt;
  final Duration? duration;
  final String? description;
  int? id;
  int timeSpent;
  int timeGoal;
  bool shouldStart;

  HabitModel({
    this.name,
    this.id,
    this.description,
    required this.timeSpent,
    required this.timeGoal,
    this.startedAt,
    this.duration,
    this.shouldStart = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startedAt': startedAt!.toIso8601String(),
      'timeSpent': timeSpent,
      'timeGoal': timeGoal,
      'shouldStart': shouldStart ? 0 : 1,
      'description': description,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      name: map['name'],
      startedAt: DateTime.parse(map['startedAt'] as String),
      timeSpent: map['timeSpent']?.toInt(),
      timeGoal: map['timeGoal']?.toInt(),
      shouldStart: map['shouldStart'] == 0,
      description: map['description'],
    );
  }
}
