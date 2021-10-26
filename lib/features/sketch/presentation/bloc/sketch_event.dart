part of 'sketch_bloc.dart';

@immutable
abstract class SketchEvent {}

class SketchLoadTemplate extends SketchEvent {
  final TemplateType type;
  SketchLoadTemplate({required this.type});
}

class SketchUpdateProperties extends SketchEvent {
  final SketchTemplate template;
  SketchUpdateProperties(this.template);
}

class SketchToggleTextPopup extends SketchEvent {
  final SketchTemplate template;
  final int coordinateIndex;
  final InteractionType interactionType;

  SketchToggleTextPopup(
      {required this.template,
      required this.coordinateIndex,
      required this.interactionType});
}
