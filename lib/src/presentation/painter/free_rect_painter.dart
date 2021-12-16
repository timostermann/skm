import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skm_services/src/data/enums/interaction_type.dart';
import 'package:skm_services/src/data/models/sketch_template.dart';
import 'package:skm_services/src/presentation/blocs/sketch/sketch_bloc.dart';
import 'package:skm_services/src/presentation/widgets/point.dart';
import 'package:touchable/touchable.dart';

import 'base_sketch_painter.dart';

class FreeRectPainter extends BaseSketchPainter {
  FreeRectPainter(context, template) : super(context, template);

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

    drawNode(
      canvas: touchyCanvas,
      center: constraints[1],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  0,
                  dragDetails.localPosition.dx,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 0,
                interactionType: InteractionType.horizontal,
              ),
            );
      },
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[2],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  2,
                  dragDetails.localPosition.dx,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 2,
                interactionType: InteractionType.horizontal,
              ),
            );
      },
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[3],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  1,
                  dragDetails.localPosition.dy,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 1,
                interactionType: InteractionType.vertical,
              ),
            );
      },
    );
  }
}
