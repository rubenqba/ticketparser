import 'dart:io';

abstract class TextDetector {
  Future<List<String>> recognizeTextFromInputImage(File imageFile);
  
  Future<List<String>> recognizeTextFromPath(String imagePath);
}
