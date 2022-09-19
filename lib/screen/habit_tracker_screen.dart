import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../widget/custom_modal_bottom_sheet.dart';
import '../model/habit_model.dart';
import '../widget/habit_list_tile.dart';
import 'add_new_habit_screen.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({Key? key}) : super(key: key);

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  var habits = <HabitModel>[];
  Duration duration = const Duration();

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
  Timer? t;
  void startAndPauseTimer(HabitModel habits) {
    setState(() {
      habits.shouldStart = !habits.shouldStart;
    });
    if (habits.shouldStart) {
      t = Timer.periodic(habits.duration!, (t) {
        setState(() {
          if (habits.timeSpent + 1 == habits.timeGoal) {
            t.cancel();
            Future.delayed(
                const Duration(seconds: 2), () => showNotification(habits));
          }

          if (!t.isActive) habits.shouldStart = false;
          habits.timeSpent++;
        });
      });
    } else {
      t!.cancel();
    }
  }

  Future<void> showNotification(HabitModel habits) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'habit_channel',
            title: habits.name,
            body: "${habits.timeSpent} / ${habits.timeGoal}",
            displayOnForeground: true,
            displayOnBackground: true,
            category: NotificationCategory.Workout,
            wakeUpScreen: true,
            fullScreenIntent: true));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: const Text('Habit tracker'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.history))
          ],
        ),
        body: habits.isEmpty
            ? const Center(
                child: Icon(
                Icons.add_task,
                size: 100,
                color: Colors.grey,
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Today',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
                    progressColor:
                        totalPercentage == 1 ? Colors.green : Colors.indigo,
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
                              countDownDuration: duration,
                              habitStarted: habits[i].shouldStart,
                              startTimer: () => startAndPauseTimer(habits[i]),
                              progress: calculateProgress(i),
                              percentage: calculatePercentage(i),
                            )),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HabitModel result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddNewHabitScreen()));
            setState(() {
              if (result == null) return;
              habits.add(result);
              startAndPauseTimer(result);
              duration = result.duration!;
            });
          },
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
