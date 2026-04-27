import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task4/features/chat/binding/binding.dart';
import 'package:task4/features/chat/controller/voice_controller.dart';

class ChatScreen extends GetView<VoiceController> {
  const ChatScreen({super.key});

  static const name = "/";
  static final page = GetPage(
      name: name,
      page: () => ChatScreen(),
      binding: VoiceBinding()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Recording App", style: TextStyle(color: Colors.white)),
          ),

          body: Center(
            child: GetBuilder<VoiceController>(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onLongPressStart: (_) {
                        controller.startRecording();
                      },
                      onLongPressMoveUpdate: (details) {
                        if (details.offsetFromOrigin.dy < -50) {
                          controller.lockRecording();
                        }
                        if (details.offsetFromOrigin.dx < -50) {
                          controller.cancelRecording();
                        }},
                      onLongPressEnd: (_) {
                        controller.handleRelease();
                      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.state == RecordState.recording ? 80 : 60,
                  height: controller.state == RecordState.recording ? 80 : 60,
                  decoration: BoxDecoration(
                     shape: BoxShape.circle,
                         color: controller.state == RecordState.recording
                           ? Colors.red
                           : Colors.green,
                     boxShadow: controller.state == RecordState.recording
                     ? [
                BoxShadow(
                color: Colors.red.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 5,
                ),
                ]
                : [],
                ),
                child: const Icon(Icons.mic, color: Colors.white),
                ),
                    ),
                    if (controller.isLocked)
                      FloatingActionButton(
                        backgroundColor: Colors.green,
                        shape: CircleBorder(),
                        elevation: 3,
                        child: const Icon(Icons.stop,color: Colors.white),
                        onPressed: () {
                          controller.stopRecording();
                        },
                      ),
                    if (controller.currentPath != null)
                      FloatingActionButton(
                        backgroundColor: Colors.blue,
                        shape: CircleBorder(),
                        elevation: 3,
                        child: const Icon(Icons.play_arrow,color: Colors.white),
                        onPressed: () {
                          controller.playVoice();
                        },
                      ),
                    if (controller.state == RecordState.recording && !controller.isLocked)
                      const Text("← Slide to cancel"),
                  ],
                );
              }
            ),
          ),
        );
  }
}