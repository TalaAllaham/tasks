import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

enum RecordState {
  ready,
  recording,
  cancelled,
  completed
}

class VoiceController extends GetxController {
  final record = AudioRecorder();
  final AudioPlayer player = AudioPlayer();
  bool isLocked = false;
  String? currentPath;
  RecordState state = RecordState.ready;

  Future<void> startRecording() async {
    if (state == RecordState.recording) return;

    final hasPermission = await record.hasPermission();
    if (!hasPermission) return;

    state = RecordState.recording;
    isLocked = false;
    update();

    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await record.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: filePath,
    );
  }

  Future<void> stopRecording() async {
    final path = await record.stop();

    if (path != null) {
      state = RecordState.completed;
      currentPath = path;
    } else {
      state = RecordState.cancelled;
    }

    isLocked = false;
    update();
  }

  Future<void> cancelRecording() async {
    await record.stop();
    currentPath = null;
    state = RecordState.cancelled;
    isLocked = false;
    update();
  }

  Future<void> playVoice() async {
    if (currentPath == null) {
      return;
    }
      await player.setFilePath(currentPath!);
      await player.play();
  }

  void lockRecording() {
    if (!isLocked) {
      isLocked = true;
      update();
    }
  }

  Future<void> handleRelease() async {
    if (!isLocked && state != RecordState.cancelled) {
      await stopRecording();
    }
  }
}