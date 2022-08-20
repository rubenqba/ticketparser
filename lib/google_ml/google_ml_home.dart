import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ticketparser/bloc/text_detector_bloc.dart';
import 'package:ticketparser/config/image_picker.dart';
import 'package:ticketparser/repository/google_ml_text_detector.dart';
import 'package:ticketparser/repository/text_detector.dart';

class GoogleMLHome extends StatefulWidget {
  const GoogleMLHome({super.key});

  @override
  State<GoogleMLHome> createState() => _GoogleMLHomeState();
}

class _GoogleMLHomeState extends State<GoogleMLHome> {
  List<ImageObject> _imgObjs = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    ImagePickerConfiguration.configImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      color: Colors.grey.shade100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_imgObjs.isEmpty)
              Container(
                width: 300,
                height: 300,
                color: Colors.grey.shade300,
              ),
            if (_imgObjs.isNotEmpty)
              Container(
                width: 300,
                height: 300,
                child: Image.file(
                  File(_imgObjs[0].modifiedPath),
                  fit: BoxFit.cover,
                ),
              ),
            if (_imgObjs.isEmpty)
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    shadowColor: Colors.grey.shade400,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _openCameraOrGallery(),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.camera,
                        size: 32,
                      ),
                      Text('Select image')
                    ],
                  ),
                ),
              ),
            if (_imgObjs.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    shadowColor: Colors.grey.shade400,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _parseTicket(context),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.emoji_objects_outlined,
                        size: 32,
                      ),
                      Text('Parse text')
                    ],
                  ),
                ),
              ),
            if (_imgObjs.isNotEmpty) const TextRecognitionResult(),
            if (_imgObjs.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    shadowColor: Colors.grey.shade400,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _restartAnalysis,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.emoji_objects_outlined,
                        size: 32,
                      ),
                      Text('Restart Analysis')
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openCameraOrGallery() {
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

  void _parseTicket(BuildContext context) {
    BlocProvider.of<TextDetectorBloc>(context).add(
      TextDetectorPath(_imgObjs[0].modifiedPath),
    );
  }

  void _restartAnalysis() {
    setState(() {
      _imgObjs.clear();
    });
    BlocProvider.of<TextDetectorBloc>(context).add(TextDetectorInit());
  }
}

class TextRecognitionResult extends StatelessWidget {
  const TextRecognitionResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 300,
      height: 300,
      color: Colors.grey.shade300,
      child: _value(),
    );
  }

  Widget _value() {
    String query = [
      'RFC',
      'FOLIO',
      'R.F.C.',
      'EADT',
      'Autorizacion',
      'Refern',
    ].join(" ");
    return BlocBuilder<TextDetectorBloc, TextDetectorState>(
      builder: (context, state) {
        if (state is TextDetectionInProgress) {
          return const CircularProgressIndicator(
            color: Colors.indigo,
          );
        }
        if (state is TextDetectionCompleted) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RichText(
              text: TextSpan(
                children: highlightOccurrences(state.textRecognized.join("\n"), query),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
        return const Text('');
      },
    );
  }

  List<TextSpan> highlightOccurrences(String source, String? query) {
    if (query == null || query.isEmpty) {
      return [TextSpan(text: source)];
    }

    var matches = <Match>[];
    for (final token in query.trim().toLowerCase().split(' ')) {
      matches.addAll(token.allMatches(source.toLowerCase()));
    }

    if (matches.isEmpty) {
      return [TextSpan(text: source)];
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
