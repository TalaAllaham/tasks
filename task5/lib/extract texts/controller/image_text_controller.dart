import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageController {

  final ImagePicker picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile =
    await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  final textRecognizer = TextRecognizer();

  Future<String> extractTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }
  void dispose() {
  textRecognizer.close();
  }
}