import 'package:flutter/material.dart';
import 'package:skm_services/enums/interaction_type.dart';
import 'package:skm_services/components/sketch_components/point.dart';
import 'package:skm_services/features/sketch/presentation/bloc/sketch_bloc.dart';
import 'package:skm_services/models/sketch_template.dart';
import 'package:touchable/touchable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseSketchPainter extends CustomPainter {
  final BuildContext context;
  final SketchTemplate template;

  BaseSketchPainter(this.context, this.template);

  void paint(Canvas canvas, Size size);

  void drawNode(TouchyCanvas canvas, Point center,
      Function(DragUpdateDetails)? onPanUpdate, [Function(LongPressStartDetails)? onLongPress]) {
    canvas.drawCircle(
      center.offset,
      20,
      Paint()..color = center.interactionType.color,
      onPanUpdate: onPanUpdate,
      onPanStart: (dragDownDetails) {
        DragUpdateDetails dragDetails = DragUpdateDetails(
          globalPosition: dragDownDetails.globalPosition,
          localPosition: dragDownDetails.localPosition,
          sourceTimeStamp: dragDownDetails.sourceTimeStamp,
        );
        if (onPanUpdate != null) onPanUpdate(dragDetails);
        print("dragged!");
      },
      onTapDown: (tapDownDetails) {
        DragUpdateDetails dragDetails = DragUpdateDetails(
          globalPosition: tapDownDetails.globalPosition,
          localPosition: tapDownDetails.localPosition,
        );
        if (onPanUpdate != null) onPanUpdate(dragDetails);
        print("tapped!");
      },
      onLongPressStart: (longPressStartDetails) {
        if (onLongPress != null) onLongPress(longPressStartDetails);
      }
    );
  }

  void drawLine(TouchyCanvas canvas, Point start, Point end) {
    canvas.drawLine(
      start.offset,
      end.offset,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(BaseSketchPainter ldDelegate) {
    return true;
  }
}
