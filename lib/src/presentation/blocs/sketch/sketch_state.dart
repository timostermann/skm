part of 'sketch_bloc.dart';

@immutable
abstract class SketchState {
  final SketchTemplate template;

  SketchState(this.template);
}

class SketchLoaded extends SketchState {
  SketchLoaded({required template}) : super(template);
}

class SketchShowTextField extends SketchState {
  final int coordinateIndex;
  final InteractionType interactionType;

  SketchShowTextField({
    required template,
    required this.coordinateIndex,
    required this.interactionType,
  }) : super(template);
}
