import 'package:flutter/material.dart';
import 'local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    NotificationService.requestAndroidPermission();
    NotificationService.requestIOSPermission();
  }

  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () =>
                      NotificationService.showNotification(
                          "Hello !", "Have a nice day"),
                  child: Text("send notification")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => pickTimeAndSchedule(context),
                child: Text("select time"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  NotificationService.cancelAll();
                },
                child: Text("delete all notifications"),
              ),
            ],
          ),
        ));
  }

}