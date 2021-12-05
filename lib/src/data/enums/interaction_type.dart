import 'package:flutter/material.dart';
import 'package:skm_services/src/config/styles.dart';

enum InteractionType { none, horizontal, vertical, angle }

extension InteractionTypeMappings on InteractionType {
  static const Map<InteractionType, Color> typeColors = {
    InteractionType.horizontal: SkColors.alternative1,
    InteractionType.vertical: SkColors.alternative2,
    InteractionType.angle: SkColors.alternative3
  };

  Color get color => typeColors[this] ?? Colors.black;
}
