import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ticketparser/repository/text_detector.dart';

class GoogleMLTextDetector extends TextDetector {
  final TextRecognizer _recognizer = GoogleMlKit.vision.textRecognizer();

  @override
  Future<List<String>> recognizeTextFromInputImage(File imageFile) => _recognizer.processImage(InputImage.fromFile(imageFile)).then(_parseResults);

  Future<List<String>> _parseResults(RecognizedText result) {
    var list = List<String>.empty(growable: true);
    // var list2 = result.blocks
    //   .map((b) => b.lines.map((l) => l.text).toList(growable: true))
    //   .reduce((value, element) => value + element);

    for (var block in result.blocks) {
      for (var line in block.lines) {
        list.add(line.text);
      }
    }
    return Future.value(list);
  }

  @override
  Future<List<String>> recognizeTextFromPath(String imagePath) => recognizeTextFromInputImage(File(imagePath));
}
