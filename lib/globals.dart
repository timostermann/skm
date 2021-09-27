import 'package:flutter/material.dart';
import 'dart:math' as math;

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool isTablet(BuildContext context, [bool? useHeight]) {
  if (useHeight ?? false) {
    return getHeight(context) > 800;
  } else {
    return getWidth(context) > 700;
  }
}

double roundToNthDecimal(double number, int n) {
  num mod = math.pow(10.0, n);
  return ((number * mod).round().toDouble() / mod);
}

double getBetaAngle(num a, num b, int? decimals) {
  return decimals != null
      ? roundToNthDecimal(arcToSquareMeasure(math.atan(a / b)), decimals)
      : arcToSquareMeasure(math.atan(a / b));
}

double arcToSquareMeasure(double arc) {
  return arc * (180.0 / math.pi);
}

double squareToArcMeasure(double square) {
  return square * (math.pi / 180);
}

double sineLaw(double alpha, double a, double beta) {
  return (a / math.sin(alpha)) * math.sin(beta);
}

double getAngleByAngleSum(double alpha, double beta) {
  return 180.0 - alpha - beta;
}
