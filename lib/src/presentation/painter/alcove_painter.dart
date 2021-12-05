import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skm_services/src/data/enums/interaction_type.dart';
import 'package:skm_services/src/data/models/sketch_template.dart';
import 'package:skm_services/src/presentation/blocs/sketch/sketch_bloc.dart';
import 'package:skm_services/src/presentation/widgets/sketch_widgets/point.dart';
import 'package:touchable/touchable.dart';

import 'base_sketch_painter.dart';

class AlcovePainter extends BaseSketchPainter {
  AlcovePainter(context, template) : super(context, template);

  @override
  void paint(Canvas canvas, Size size) {
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    List<Point> constraints = [
      Point(0, 0),
      Point.interactable(
        offset: Offset(0, template.interactiveCoordinates[0]),
        interactionType: InteractionType.vertical,
      ),
      Point(100, template.interactiveCoordinates[0]),
      Point.interactable(
        offset: Offset(100 + template.interactiveCoordinates[5],
            template.interactiveCoordinates[0]),
        interactionType: InteractionType.horizontal,
      ),
      Point(200 + template.interactiveCoordinates[5],
          template.interactiveCoordinates[0]),
      Point.interactable(
        offset: Offset(
            200 + template.interactiveCoordinates[5],
            template.interactiveCoordinates[0] -
                template.interactiveCoordinates[4]),
        interactionType: InteractionType.vertical,
      ),
      Point.interactable(
        offset: Offset(
            100 +
                template.interactiveCoordinates[5] +
                template.interactiveCoordinates[3],
            template.interactiveCoordinates[0] -
                template.interactiveCoordinates[4]),
        interactionType: InteractionType.angle,
      ),
      Point.interactable(
        offset: Offset(100 + template.interactiveCoordinates[2], 0),
        interactionType: InteractionType.horizontal,
      ),
      Point.interactable(
        offset: Offset(100 + template.interactiveCoordinates[1], 0),
        interactionType: InteractionType.angle,
      ),
    ];

    drawLine(touchyCanvas, constraints[0], constraints[1]);
    drawLine(touchyCanvas, constraints[1], constraints[2]);
    drawLine(touchyCanvas, constraints[2], constraints[3]);
    drawLine(touchyCanvas, constraints[3], constraints[4]);
    drawLine(touchyCanvas, constraints[4], constraints[5]);
    drawLine(touchyCanvas, constraints[5], constraints[6]);
    drawLine(touchyCanvas, constraints[6], constraints[7]);
    drawLine(touchyCanvas, constraints[7], constraints[8]);
    drawLine(touchyCanvas, constraints[8], constraints[0]);
    drawLine(touchyCanvas, constraints[2], constraints[8]);
    drawLine(touchyCanvas, constraints[3], constraints[6]);

    drawNode(
      canvas: touchyCanvas,
      center: constraints[1],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  0,
                  dragDetails.localPosition.dy,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 0,
                interactionType: InteractionType.vertical,
              ),
            );
      },
      textCanvas: canvas,
      interactionType: InteractionType.vertical,
      textPosition: TextPosition.bottom,
      text: template.interactiveCoordinates[0].toString(),
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[3],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  5,
                  dragDetails.localPosition.dx - 100,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 5,
                interactionType: InteractionType.horizontal,
              ),
            );
      },
      textCanvas: canvas,
      interactionType: InteractionType.horizontal,
      textPosition: TextPosition.bottom,
      text: template.interactiveCoordinates[5].toString(),
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[5],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  4,
                  template.interactiveCoordinates[0] -
                      dragDetails.localPosition.dy,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 4,
                interactionType: InteractionType.vertical,
              ),
            );
      },
      textCanvas: canvas,
      interactionType: InteractionType.vertical,
      textPosition: TextPosition.right,
      text: template.interactiveCoordinates[4].toString(),
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[6],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  3,
                  dragDetails.localPosition.dx -
                      100 -
                      template.interactiveCoordinates[5],
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 3,
                interactionType: InteractionType.angle,
              ),
            );
      },
      textCanvas: canvas,
      interactionType: InteractionType.angle,
      textPosition: TextPosition.top,
      text: template.interactiveCoordinates[3].toString(),
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[7],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  2,
                  dragDetails.localPosition.dx - 100,
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
      textCanvas: canvas,
      interactionType: InteractionType.horizontal,
      textPosition: TextPosition.top,
      text: template.interactiveCoordinates[2].toString(),
    );

    drawNode(
      canvas: touchyCanvas,
      center: constraints[8],
      onPanUpdate: (dragDetails) {
        context.read<SketchBloc>().add(
              SketchUpdateProperties(
                SketchTemplate.copy(
                  template,
                  1,
                  dragDetails.localPosition.dx - 100,
                ),
              ),
            );
      },
      onTapDown: (tapDetails) {
        context.read<SketchBloc>().add(
              SketchToggleTextPopup(
                template: template,
                coordinateIndex: 1,
                interactionType: InteractionType.angle,
              ),
            );
      },
      textCanvas: canvas,
      interactionType: InteractionType.angle,
      textPosition: TextPosition.top,
      text: template.interactiveCoordinates[1].toString(),
    );
  }
}
