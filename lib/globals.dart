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

double getBetaAngle(num aLength, num bLength, int? decimals) {
  return decimals != null
      ? roundToNthDecimal(
          arcToSquareMeasure(math.atan(aLength / bLength)), decimals)
      : arcToSquareMeasure(math.atan(aLength / bLength));
}

double arcToSquareMeasure(double arc) {
  return arc * (180.0 / math.pi);
}

double squareToArcMeasure(double square) {
  return square * (math.pi / 180);
}

// de: Sinussatz
double lawOfSines(double alpha, double aLength, double beta) {
  return (aLength / math.sin(alpha)) * math.sin(beta);
}

// de: Kosinussatz
double lawOfCosines(double alpha, double beta, double gamma) {
  return math.sqrt(math.pow(alpha, 2) +
      math.pow(beta, 2) -
      2 * alpha * beta * math.cos(squareToArcMeasure(gamma)));
}

double getAngleByAngleSum(double alpha, double beta) {
  return 180.0 - alpha - beta;
}
