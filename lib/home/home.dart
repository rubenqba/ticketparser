import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ImageObject> _imgObjs = [];
  bool isTextScanning = false;
  String recognizedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Parser Demo'),
        actions: const [],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _imgObjs.isNotEmpty
              ? Image.file(
                  File(_imgObjs[0].modifiedPath),
                  height: 80,
                  fit: BoxFit.cover,
                )
              : Container(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
              onPressed: _buttonClicked,
              heroTag: 'button1',
              child: const Icon(Icons.camera),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
              onPressed: _buttonClicked,
              heroTag: 'button2',
              child: const Icon(Icons.camera_roll),
            ),
          ),
        ],
      ),
    );
  }

  void _buttonClicked() {
    debugPrint('button clicked!');
    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, __) {
      return const ImagePicker(maxCount: 1);
    })).then((values) => _saveImages(values));
  }

  void _saveImages(List<ImageObject>? values) {
    if ((values?.length ?? 0) > 0) {
      setState(() {
        _imgObjs = values!;
      });
    }
  }
}
