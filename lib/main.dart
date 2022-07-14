import 'dart:async';
import 'dart:math' as m;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/habit_tracker_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.indigo,
      title: 'Habit Tracker',
      home: HabitTrackerScreen(),
    );
  }
}

Future<void> initNotification() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'habit_channel',
        channelName: 'habit nofitications',
        channelDescription: 'Notification channel for habit tracker',
        defaultColor: Colors.indigo)
  ]);
}

class MathTest extends StatefulWidget {
  const MathTest({Key? key}) : super(key: key);

  @override
  State<MathTest> createState() => _MathTestState();
}

class _MathTestState extends State<MathTest> {
  final name = TextEditingController();
  final timeSpent = TextEditingController();
  final timeGoal = TextEditingController();
  double radius = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            cursorColor: Colors.black,
            cursorWidth: 1,
            validator: (val) => val!.isEmpty ? 'field is required' : null,
            controller: timeGoal,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter time Goal'),
          ),
          MaterialButton(
            height: 58,
            color: Colors.lightGreen,
            minWidth: double.infinity,
            onPressed: () {
              double areaOfACircle = m.pi * m.pow(radius, 2);
              print(areaOfACircle);
            },
            child: const Text('Add'),
          )
        ],
      ),
    ));
  }
}
