import 'package:flutter/material.dart';
import 'package:skm_services/styles.dart';

enum InteractionType { none, horizontal, vertical, angle }

extension InteractionTypeMappings on InteractionType {
  static const Map<InteractionType, Color> typeColors = {
    InteractionType.horizontal: SkColors.accent600,
    InteractionType.vertical: SkColors.main500,
    InteractionType.angle: Colors.deepPurple
  };

  Color get color => typeColors[this] ?? Colors.black;
}
