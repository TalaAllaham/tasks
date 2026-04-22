import 'dart:async';

class LetterAnimationController {
  final List<String> letters;

  LetterAnimationController(this.letters);

  List<bool> visible = [];

  void init() {
    visible = List.filled(letters.length, false);
  }

  Future<void> start(Function(int index) onUpdate) async {
    for (int i = 0; i < letters.length; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      onUpdate(i);
    }
  }
}