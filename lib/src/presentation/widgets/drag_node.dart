import 'package:flutter/material.dart';

class DragNode extends StatelessWidget {
  DragNode(this._color, this._borderColor);

  final Color _color;
  final Color _borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: _borderColor,
          width: 1,
        ),
      ),
    );
  }
}
