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

double getBetaAngle(num aLength, num bLength, [int? decimals]) {
  return decimals != null
      ? roundToNthDecimal(
          radianToAngleMeasure(math.atan(aLength / bLength)), decimals)
      : radianToAngleMeasure(math.atan(aLength / bLength));
}

double radianToAngleMeasure(double angle) {
  return angle * (180.0 / math.pi);
}

double angleToRadianMeasure(double radian) {
  return radian * (math.pi / 180);
}

double getAngleByAngleSum(double alpha, double beta) {
  return 180.0 - alpha - beta;
}
