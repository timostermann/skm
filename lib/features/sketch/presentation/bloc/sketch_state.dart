part of 'sketch_bloc.dart';

@immutable
abstract class SketchState {}

class SketchInitial extends SketchState {}

class SketchLoaded extends SketchState {
  final SketchTemplate template;

  SketchLoaded({required this.template});
}

class SketchShowTextField extends SketchState {
  final SketchTemplate template;
  final int coordinateIndex;

  SketchShowTextField({required this.template, required this.coordinateIndex});
}