import 'package:flutter/material.dart';
import 'package:skm_services/src/config/styles.dart';

import 'line_input.dart';

class DragLine extends StatelessWidget {
  final double _length;
  final double _angle;
  final Offset _offset;
  final void Function(String)? _onSubmitted;
  final bool _isVertical;
  final bool _hasInput;

  const DragLine({
    required double length,
    double angle = 0.0,
    Offset offset = const Offset(0.0, 0.0),
    void Function(String)? onSubmitted,
    bool isVertical = false,
    bool hasInput = true,
  })  : _length = length,
        _angle = angle,
        _offset = offset,
        _onSubmitted = onSubmitted,
        _isVertical = isVertical,
        _hasInput = hasInput;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Transform.translate(
        offset: _offset,
        child: Transform.rotate(
          angle: _angle,
          child: Transform.scale(
            scale: _angle > 0.0 ? 1.2 : 1.0,
            child: Container(
              height: _isVertical ? _length : 10,
              width: _isVertical ? 10 : _length,
              margin: _isVertical ? EdgeInsets.only(right: 10) : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: SkColors.main800,
              ),
            ),
          ),
        ),
      ),
      _hasInput
          ? LineInput(
              defaultValue: _length,
              onSubmitted: _onSubmitted,
            )
          : Container(),
    ];

    if (_isVertical) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    }
  }
}
