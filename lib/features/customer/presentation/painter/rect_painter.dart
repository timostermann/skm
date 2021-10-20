import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skm_services/components/sketch_components/point.dart';
import 'package:skm_services/enums/interaction_type.dart';
import 'package:skm_services/features/sketch/presentation/bloc/sketch_bloc.dart';
import 'package:skm_services/models/sketch_template.dart';
import 'package:touchable/touchable.dart';

import 'base_sketch_painter.dart';

class RectPainter extends BaseSketchPainter {
  RectPainter(context, template) : super(context, template);

  @override
  void paint(Canvas canvas, Size size) {
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    List<Point> constraints = [
      Point(0, 0),
      Point.interactable(
        offset: Offset(template.interactiveCoordinates[0], 0),
        interactionType: InteractionType.horizontal,
      ),
      Point.interactable(
        offset: Offset(template.interactiveCoordinates[2],
            template.interactiveCoordinates[1]),
        interactionType: InteractionType.angle,
      ),
      Point.interactable(
        offset: Offset(template.interactiveCoordinates[0],
            template.interactiveCoordinates[1]),
        interactionType: InteractionType.vertical,
      ),
    ];

    drawLine(touchyCanvas, constraints[0], constraints[1]);
    drawLine(touchyCanvas, constraints[0], constraints[2]);
    drawLine(touchyCanvas, constraints[1], constraints[3]);
    drawLine(touchyCanvas, constraints[2], constraints[3]);

    drawNode(touchyCanvas, constraints[1], (dragDetails) {
      context.read<SketchBloc>().add(
            SketchUpdateProperties(SketchTemplate.copy(
              template,
              0,
              dragDetails.localPosition.dx,
            )),
          );
      print("dragging");
    });

    drawNode(
      touchyCanvas,
      constraints[2],
      (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(SketchTemplate.copy(
                  template, 2, dragDetails.localPosition.dx)),
            );
      },
      (longPressDetails) => context.read<SketchBloc>().add(
            SketchToggleTextPopup(
              template: template,
              coordinateIndex: 2,
            ),
          ),
    );

    drawNode(touchyCanvas, constraints[3], (dragDetails) {
      context.read<SketchBloc>().add(
            SketchUpdateProperties(
                SketchTemplate.copy(template, 1, dragDetails.localPosition.dy)),
          );
    });
  }
}
