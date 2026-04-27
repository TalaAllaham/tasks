import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task4/features/chat/controller/voice_controller.dart';

class VoiceBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(()=> VoiceController());
   }
}
