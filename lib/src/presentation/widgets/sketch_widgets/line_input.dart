import 'package:flutter/material.dart';
import 'package:skm_services/src/config/styles.dart';

class LineInput extends StatelessWidget {
  final double _default;
  final void Function(String)? _onSubmitted;

  const LineInput({
    required double defaultValue,
    void Function(String)? onSubmitted,
  })  : _default = defaultValue,
        _onSubmitted = onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: TextField(
        controller: TextEditingController(text: _default.toString()),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: SkColors.accent300,
        ),
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
