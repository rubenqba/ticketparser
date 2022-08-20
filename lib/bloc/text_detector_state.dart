part of 'text_detector_bloc.dart';

@immutable
abstract class TextDetectorState extends Equatable {}

class TextDetectionEmpty extends TextDetectorState {
  @override
  List<Object?> get props => [];
}

class TextDetectionInProgress extends TextDetectorState {
  @override
  List<Object?> get props => [];
}

class TextDetectionCompleted extends TextDetectorState {
  final List<String> textRecognized;

  TextDetectionCompleted(this.textRecognized);

  @override
  List<Object?> get props => [textRecognized];
}
