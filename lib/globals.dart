import 'package:flutter/material.dart';

bool isTablet(BuildContext context, [bool? useHeight]) {
  if (useHeight ?? false) {
    return MediaQuery.of(context).size.height > 800;
  } else {
    return MediaQuery.of(context).size.width > 700;
  }
}
