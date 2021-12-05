import 'package:flutter/material.dart';
import 'package:skm_services/src/data/enums/interaction_type.dart';

class Point {
  InteractionType interactionType;
  Offset offset;

  Point.interactable({required this.offset, required this.interactionType});

  Point(double dx, double dy)
      : interactionType = InteractionType.none,
        offset = Offset(dx, dy);
}
