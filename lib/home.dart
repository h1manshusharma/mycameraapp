import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future openCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future openGallery() async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(picture!.path);
    });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: openCamera,
                    child: const Text(
                      "Take Picture",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    onTap: openGallery,
                    child: const Text(
                      "Pick from gallery",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Camera App"),
      ),
      body: Center(
        child: _image == null
            ? const Text('No Image')
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(_image!),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optionsDialogBox,
        tooltip: 'Open Camera',
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
