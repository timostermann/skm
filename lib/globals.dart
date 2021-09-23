import 'package:flutter/material.dart';

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
