import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:skm_services/enums/interaction_type.dart';
import 'package:skm_services/components/sketch_components/point.dart';
import 'package:skm_services/features/sketch/presentation/bloc/mode_bloc.dart';
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
      Function(TapDownDetails)? onTapDown}) {
    canvas.drawCircle(
      center.offset,
      18,
      Paint()..color = center.interactionType.color,
      onPanUpdate: (dragUpdateDetails) {
        if (context.read<ModeBloc>().state is DragMode && onPanUpdate != null) {
          onPanUpdate(dragUpdateDetails);
        }
      },
      onPanStart: (dragDownDetails) {
        if (context.read<ModeBloc>().state is DragMode && onPanUpdate != null) {
          DragUpdateDetails dragDetails = DragUpdateDetails(
            globalPosition: dragDownDetails.globalPosition,
            localPosition: dragDownDetails.localPosition,
            sourceTimeStamp: dragDownDetails.sourceTimeStamp,
          );
          onPanUpdate(dragDetails);
        }
      },
      onTapDown: (tapDownDetails) {
        if (context.read<ModeBloc>().state is InputMode && onTapDown != null) {
          onTapDown(tapDownDetails);
        } else if (context.read<ModeBloc>().state is DragMode &&
            onPanUpdate != null) {
          DragUpdateDetails dragDetails = DragUpdateDetails(
            globalPosition: tapDownDetails.globalPosition,
            localPosition: tapDownDetails.localPosition,
          );
          onPanUpdate(dragDetails);
        }
      },
      onLongPressMoveUpdate: (longPressDetails) {
        if (context.read<ModeBloc>().state is DragMode && onPanUpdate != null) {
          DragUpdateDetails dragDetails = DragUpdateDetails(
            globalPosition: longPressDetails.globalPosition,
            localPosition: longPressDetails.localPosition,
          );
          onPanUpdate(dragDetails);
        }
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
