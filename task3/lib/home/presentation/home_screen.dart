import 'package:flutter/material.dart';
import '../controller/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> letters = ["W", "E", "L", "C", "O", "M", "E"];

  late LetterAnimationController controller;
  List<bool> visible = [];

  @override
  void initState() {
    super.initState();
    controller = LetterAnimationController(letters);
    controller.init();
    visible = controller.visible;
    controller.start((index) {
      setState(() {
        visible[index] = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(letters.length, (i) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: visible[i] ? 1 : 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset: visible[i]
                    ? Offset.zero
                    : const Offset(0, 0.5),
                child: Text(
                  letters[i],
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}