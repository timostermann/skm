import 'package:flutter/material.dart';
import 'package:skm_services/styles.dart';

class DragLine extends StatelessWidget {
  DragLine(this._width);

  final _width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: SkColors.main800,
          ),
        ),
      ],
    );
  }
}
