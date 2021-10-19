import 'package:flutter/material.dart';
import 'package:skm_services/components/sketch_components/interaction_type.dart';
import 'package:skm_services/components/sketch_components/point.dart';
import 'package:skm_services/components/sketch_components/position_controller.dart';
import 'package:skm_services/styles.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';

class SketchPainter extends CustomPainter {
  final BuildContext context;
  final PaintingController controller;

  SketchPainter(this.context)
      : controller = Provider.of<PaintingController>(context, listen: false);

  Map<InteractionType, Color> circleColors = {
    InteractionType.horizontal: SkColors.accent600,
    InteractionType.vertical: SkColors.main500,
    InteractionType.angle: Colors.deepPurple
  };

  @override
  void paint(Canvas canvas, Size size) {
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    List<Point> constraints = [
      Point(0, 0),
      Point.interactable(
        offset: Offset(controller.interactiveCoordinates![0], 0),
        interactionType: InteractionType.horizontal,
      ),
      Point.interactable(
        offset: Offset(controller.interactiveCoordinates![2],
            controller.interactiveCoordinates![1]),
        interactionType: InteractionType.angle,
      ),
      Point.interactable(
        offset: Offset(controller.interactiveCoordinates![0],
            controller.interactiveCoordinates![1]),
        interactionType: InteractionType.vertical,
      ),
    ];

    drawLine(touchyCanvas, constraints[0], constraints[1]);
    drawLine(touchyCanvas, constraints[0], constraints[2]);
    drawLine(touchyCanvas, constraints[1], constraints[3]);
    drawLine(touchyCanvas, constraints[2], constraints[3]);

    drawNode(touchyCanvas, constraints[1], (dragDetails) {
      controller.changeCoordinate(dragDetails.localPosition.dx, 0);
    });

    drawNode(touchyCanvas, constraints[2], (dragDetails) {
      controller.changeCoordinate(dragDetails.localPosition.dx, 2);
    });

    drawNode(touchyCanvas, constraints[3], (dragDetails) {
      controller.changeCoordinate(dragDetails.localPosition.dy, 1);
    });
  }

  void drawNode(TouchyCanvas canvas, Point center,
      Function(DragUpdateDetails)? onPanUpdate) {
    canvas.drawCircle(
      center.offset,
      20,
      Paint()..color = circleColors[center.interactionType] ?? Colors.black,
      onPanUpdate: onPanUpdate,
      onPanStart: (dragDownDetails) {
        DragUpdateDetails dragDetails = DragUpdateDetails(
          globalPosition: dragDownDetails.globalPosition,
          localPosition: dragDownDetails.localPosition,
          sourceTimeStamp: dragDownDetails.sourceTimeStamp,
        );
        if (onPanUpdate != null) onPanUpdate(dragDetails);
        print("dragging");
      },
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
  bool shouldRepaint(SketchPainter ldDelegate) {
    return true;
  }
}
