import 'package:flutter/material.dart';
import 'package:skm_services/enums/interaction_type.dart';
import 'package:skm_services/components/sketch_components/point.dart';
import 'package:skm_services/models/sketch_template.dart';
import 'package:touchable/touchable.dart';

abstract class BaseSketchPainter extends CustomPainter {
  final BuildContext context;
  final SketchTemplate template;

  BaseSketchPainter(this.context, this.template);

  void paint(Canvas canvas, Size size);

  void drawNode(
      {required TouchyCanvas canvas,
      required Point center,
      Function(DragUpdateDetails)? onPanUpdate,
      required Stopwatch clock,
      Function(TapDownDetails)? onDoubleTap}) {
    canvas.drawCircle(
      center.offset,
      18,
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
        print(clock.isRunning);
        if (!clock.isRunning) {
          print("tappy");
          clock.start();
          DragUpdateDetails dragDetails = DragUpdateDetails(
            globalPosition: tapDownDetails.globalPosition,
            localPosition: tapDownDetails.localPosition,
          );
          if (onPanUpdate != null) onPanUpdate(dragDetails);
          return;
        }
        print("tap");

        if (clock.elapsedMilliseconds < 500) {
          if (onDoubleTap != null) onDoubleTap(tapDownDetails);
        }
        print(clock.elapsed);

        clock.stop();
        clock.reset();
      },
      onLongPressMoveUpdate: (longPressDetails) {
        DragUpdateDetails dragDetails = DragUpdateDetails(
          globalPosition: longPressDetails.globalPosition,
          localPosition: longPressDetails.localPosition,
        );
        if (onPanUpdate != null) onPanUpdate(dragDetails);
      },
    );
  }

  void drawLine(TouchyCanvas canvas, Point start, Point end) {
    canvas.drawLine(
      start.offset,
      end.offset,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(BaseSketchPainter ldDelegate) {
    return true;
  }
}
