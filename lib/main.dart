import 'dart:async';
import 'dart:math' as m;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
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
