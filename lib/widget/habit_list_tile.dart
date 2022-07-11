import 'package:flutter/material.dart';

class HabitListTile extends StatelessWidget {
  final String? habitName;
  final VoidCallback? onSettingTap;
  final VoidCallback? startTimer;
  final int? timeSpent;
  final int? timeGoal;
  final bool? habitStarted;
  final double? progress;

  final double? percentage;
  const HabitListTile({
    Key? key,
    this.habitName,
    this.percentage,
    this.progress,
    this.onSettingTap,
    this.timeSpent,
    this.timeGoal,
    this.habitStarted,
    this.startTimer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: onSettingTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        strokeWidth: 5.0,
                        color: Colors.indigo,
                        value: progress,
                      ),
                    ),
                    Text(
                      '${percentage!.toStringAsFixed(0)}%',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 11),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$habitName',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$timeSpent / $timeGoal',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 14),
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                    iconSize: 30,
                    onPressed: startTimer,
                    icon: Icon(!habitStarted! ? Icons.play_arrow : Icons.pause))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
