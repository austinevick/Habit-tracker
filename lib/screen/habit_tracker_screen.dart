import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../custom_modal_bottom_sheet.dart';
import '../model/habit_model.dart';
import '../widget/habit_list_tile.dart';
import 'add_new_habit_screen.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({Key? key}) : super(key: key);

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  double calculateProgress(int i) => (habits[i].timeSpent / habits[i].timeGoal);
  double calculatePercentage(int i) =>
      (habits[i].timeSpent / habits[i].timeGoal) * 100;

  double calculateTotalTimeSpent() => habits.fold(
      0, (previousValue, element) => previousValue + element.timeSpent);
  double calculateTotalTimeGoal() => habits.fold(
      0, (previousValue, element) => previousValue + element.timeGoal);

  double calculateTotalTimeSpentAndTotalTimeGoalPercentage() =>
      (calculateTotalTimeSpent() / calculateTotalTimeGoal()) * 100;
  double get totalPercentage =>
      (calculateTotalTimeSpent() / calculateTotalTimeGoal());

  void startAndPauseTimer(int i) {
    setState(() {
      habits[i].habitStarted = !habits[i].habitStarted;
    });
    if (habits[i].habitStarted) {
      Timer.periodic(habits[i].duration!, (t) {
        setState(() {
          if (!habits[i].habitStarted) t.cancel();
          if (habits[i].timeSpent + 1 == habits[i].timeGoal) {
            t.cancel();
          }
          if (!t.isActive) habits[i].habitStarted = false;
          habits[i].timeSpent++;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text('Habit tracker'),
      ),
      body: habits.isEmpty
          ? const Center(
              child: Icon(
              Icons.add_task,
              size: 150,
              color: Colors.grey,
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 5),
                LinearPercentIndicator(
                  lineHeight: 25,
                  center: Text(
                    '${calculateTotalTimeSpentAndTotalTimeGoalPercentage().toStringAsFixed(0)}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.white),
                  ),
                  barRadius: const Radius.circular(10),
                  percent: totalPercentage > 1 ? 0 : totalPercentage,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      itemCount: habits.length,
                      itemBuilder: (ctx, i) => HabitListTile(
                            habitName: habits[i].name,
                            onSettingTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (ctx) => CustomModalBottomSheet(
                                        title: habits[i].name!,
                                        button1Text: 'Delete',
                                        button2Text: 'Edit',
                                        button1OnTap: () {},
                                        button2OnTap: () {},
                                      ));
                            },
                            timeGoal: habits[i].timeGoal,
                            timeSpent: habits[i].timeSpent,
                            habitStarted: habits[i].habitStarted,
                            startTimer: () => startAndPauseTimer(i),
                            progress: calculateProgress(i),
                            percentage: calculatePercentage(i),
                          )),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddNewHabitScreen())),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
