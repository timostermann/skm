import 'package:flutter/material.dart';

class PaintingController extends ChangeNotifier {
  List<double>? interactiveCoordinates = [
    300,
    500,
    0,
  ];

  void changeCoordinate(double newPosition, int index) {
    if (interactiveCoordinates != null) {
      interactiveCoordinates![index] = newPosition;
      notifyListeners();
    }
  }
}
