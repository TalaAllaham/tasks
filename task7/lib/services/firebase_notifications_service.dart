import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notifications_service.dart';

class FireNotificationService {

  static Future<void> initFireNotification() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission();

      String? token = await messaging.getToken();
      print("FCM Token: $token");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("📩 Foreground message received");

        if (message.notification != null) {
          LocalNotificationService.showNotification(
            message.notification!.title ?? "No Title",
            message.notification!.body ?? "No Body",
          );
        }
      });

      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        print("App opened from terminated state");
      }

    } catch (e) {
      print("Firebase Messaging Error: $e");
    }
  }
}
  @pragma('vm:entry-point')
  Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  print("📩 Background message received");
  LocalNotificationService.showNotification(
    message.notification!.title ?? "No Title",
    message.notification!.body ?? "No Body",
  );
}