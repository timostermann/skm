import 'package:skm_services/enums/template_type.dart';

typedef Coordinates = List<double>;

class SketchTemplate {
  final Coordinates interactiveCoordinates;
  final TemplateType type;

  SketchTemplate({required this.interactiveCoordinates, required this.type});

  SketchTemplate.defaultCoordinates(this.type)
      : interactiveCoordinates = type.coordinates;

  factory SketchTemplate.copy(
      SketchTemplate template, int index, double changedCoordinate) {
    Coordinates coordinates = List.from(template.interactiveCoordinates);
    coordinates[index] = changedCoordinate;
    return SketchTemplate(
        interactiveCoordinates: coordinates, type: template.type);
  }

  @override
  String toString() {
    return "coordinates: " +
        interactiveCoordinates.toString() +
        "\ntype: " +
        type.toString();
  }
}
