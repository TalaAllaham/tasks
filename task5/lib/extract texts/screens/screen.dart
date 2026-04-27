import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/image_text_controller.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  File? image;
  String extractedText = "";
  bool isLoading = false;
  final controller = ImageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select image to extract text",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                  height: 20
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: image != null ?
                  Image.file(image!, height: 350, width: 300) : null
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.deepOrange,
                    child: IconButton(
                      onPressed: () async {
                        final img = await controller.pickImage(
                            ImageSource.gallery);
                        if (img != null) {
                          setState(() {
                            image = img;
                            extractedText ="";
                          });
                        }
                      },
                      icon: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Colors.deepOrange),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                      if (image != null) {
                        setState(() {
                          isLoading = true;
                        });
                        final txt = await controller.extractTextFromImage(image!);
                        setState(() {
                          isLoading = false;
                        });
                        if (txt.trim().isEmpty) {
                          setState(() {
                            extractedText = "";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No text found in the image")));
                        } else {
                          setState(() {
                            extractedText = txt;
                          });
                        }
                      }
                    },
                    child: isLoading ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ) : Text("Extract Text"),
                  ),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.deepOrange,
                    child: IconButton(
                      onPressed: () async {
                        final img = await controller.pickImage(
                            ImageSource.camera);
                        if (img != null) {
                          setState(() {
                            image = img;
                            extractedText ="";
                          });
                          }
                      },
                      icon: Icon(CupertinoIcons.photo_camera_solid),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 20
              ),
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    extractedText,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}