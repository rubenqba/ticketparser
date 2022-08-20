part of 'text_detector_bloc.dart';

@immutable
abstract class TextDetectorEvent extends Equatable {
  const TextDetectorEvent();
}

class TextDetectorInit extends TextDetectorEvent {
  @override
  List<Object?> get props => [];
}

class TextDetectorPath extends TextDetectorEvent {
  final String imagePath;

  const TextDetectorPath(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
