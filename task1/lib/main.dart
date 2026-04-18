import 'package:flutter/material.dart';
import 'package:task_1/home_screen.dart';
import 'local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotification();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);
  await NotificationService.requestAndroidPermission();
  await NotificationService.requestIOSPermission();
  await NotificationService.showNotification("Hi", "Welcome to our app !");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : HomeScreen()
    );
  }

}