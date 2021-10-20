import '../models/sketch_template.dart';

enum TemplateType { One, Two, Three }

extension TemplateTypeMappings on TemplateType {
  static const Map<TemplateType, Coordinates> coordinatesList = {
    TemplateType.One: [300, 500, 0],
    TemplateType.Two: [300, 500, 0],
    TemplateType.Three: [300, 500, 0],
  };

  Coordinates get coordinates => coordinatesList[this] ?? [];
}
