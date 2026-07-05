import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task7/services/firebase_notifications_service.dart';
import 'package:task7/services/local_notifications_service.dart';
import 'features/home/screens/home_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationService.init();
  await FireNotificationService.initFireNotification();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}