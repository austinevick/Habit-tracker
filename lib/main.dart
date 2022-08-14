import 'dart:async';
import 'dart:math' as m;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/habit_tracker_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBackgroundService();
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

Future<void> initBackgroundService() async {
  var status = await BackgroundFetch.configure(
      BackgroundFetchConfig(minimumFetchInterval: 5, stopOnTerminate: false),
      onBackgroundFetch,
      _onBackgroundFetchTimeout);
  print('background service: $status');
  BackgroundFetch.scheduleTask(TaskConfig(
      taskId: '1', delay: 1000, stopOnTerminate: false, periodic: true));
}

void onBackgroundFetch(String taskId) async {
  if (taskId == '1') {
    showNotification();
  }
}

Future<void> showNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'habit_channel',
          title: 'habits.name',
          body: "Hello",
          displayOnForeground: true,
          displayOnBackground: true,
          wakeUpScreen: true,
          fullScreenIntent: true));
}

void _onBackgroundFetchTimeout(String taskId) {
  print('[BackgroundFetch] TIMEOUT: $taskId');
  BackgroundFetch.finish(taskId);
}
