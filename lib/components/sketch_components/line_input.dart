import 'package:flutter/material.dart';
import 'package:skm_services/styles.dart';

class LineInput extends StatelessWidget {
  LineInput(this._default);

  final String _default;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: _default),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        fillColor: SkColors.accent300,
      ),
    );
  }
}
