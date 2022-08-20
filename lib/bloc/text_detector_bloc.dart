import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ticketparser/repository/google_ml_text_detector.dart';
import 'package:ticketparser/repository/text_detector.dart';

part 'text_detector_event.dart';
part 'text_detector_state.dart';

class TextDetectorBloc extends Bloc<TextDetectorEvent, TextDetectorState> {
  final TextDetector _textDetector;

  TextDetectorBloc({TextDetector? textDetector})
      : _textDetector = textDetector ?? GoogleMLTextDetector(),
        super(
          TextDetectionEmpty(),
        ) {
    on<TextDetectorInit>((event, emit) {
      debugPrint('text detector init event');
      emit(TextDetectionEmpty());
    });

    on<TextDetectorPath>((event, emit) => _recognizeText(event));
  }

  void _recognizeText(TextDetectorEvent event) {
    debugPrint('text detector recognize event');
    if (event is TextDetectorPath) {
      _textDetector.recognizeTextFromPath(event.imagePath).then(
            (value) => emit(TextDetectionCompleted(value)),
          );
    }
  }
}
