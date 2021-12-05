import '../models/sketch_template.dart';

enum TemplateType { Corner, Free, Tub, Alcove }

extension TemplateTypeMappings on TemplateType {
  static const Map<TemplateType, Coordinates> defaultCoordinates = {
    TemplateType.Corner: [300, 500, 0],
    TemplateType.Free: [5, 500, 200],
    TemplateType.Tub: [400, 400, 50],
    TemplateType.Alcove: [750, 0, 200, 0, 600, 450],
  };

  Coordinates get coordinates => defaultCoordinates[this] ?? [];
}
