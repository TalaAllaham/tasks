import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task4/features/chat/screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [ChatScreen.page,
    ]);
  }
}
