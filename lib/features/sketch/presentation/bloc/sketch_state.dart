part of 'sketch_bloc.dart';

@immutable
abstract class SketchState {
  final SketchTemplate template;

  SketchState(this.template);
}

class SketchLoaded extends SketchState {
  SketchLoaded({required template}) : super(template);
}

class SketchDragMode extends SketchState {
  SketchDragMode({required template}) : super(template);
}

class SketchInputMode extends SketchState {
  SketchInputMode({required template}) : super(template);
}

class SketchShowTextField extends SketchState {
  final int coordinateIndex;

  SketchShowTextField({required template, required this.coordinateIndex})
      : super(template);
}
