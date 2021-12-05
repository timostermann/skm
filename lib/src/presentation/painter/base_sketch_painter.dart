import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:skm_services/src/data/enums/interaction_type.dart';
import 'package:skm_services/src/data/models/sketch_template.dart';
import 'package:skm_services/src/presentation/blocs/mode/mode_bloc.dart';
import 'package:skm_services/src/presentation/widgets/sketch_widgets/point.dart';
import 'package:touchable/touchable.dart';

enum TextPosition { top, right, bottom, left }

abstract class BaseSketchPainter extends CustomPainter {
  final BuildContext context;
  final SketchTemplate template;
  final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  BaseSketchPainter(this.context, this.template);

  void paint(Canvas canvas, Size size);

  void drawNode({
    required TouchyCanvas canvas,
    required Point center,
    Function(DragUpdateDetails)? onPanUpdate,
    Function(TapDownDetails)? onTapDown,
    Canvas? textCanvas,
    InteractionType? interactionType,
    TextPosition? textPosition,
    String? text,
  }) {
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

    if (text != null && textCanvas != null) {
      TextSpan textSpan =
          TextSpan(style: TextStyle(color: Colors.black), children: [
        TextSpan(text: text, style: TextStyle(fontSize: 20)),
        getDirectionIcon(interactionType ?? InteractionType.none, text),
      ]);
      textPainter.text = textSpan;
      textPainter.layout();
      textPainter.paint(textCanvas,
          getTextPosition(center.offset, textPosition ?? TextPosition.top));
    }
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

  Offset getTextPosition(Offset nodePosition, TextPosition textPosition) {
    switch (textPosition) {
      case TextPosition.top:
        return Offset(nodePosition.dx - 25, nodePosition.dy - 50);
      case TextPosition.right:
        return Offset(nodePosition.dx + 25, nodePosition.dy - 15);
      case TextPosition.bottom:
        return Offset(nodePosition.dx - 25, nodePosition.dy + 25);
      case TextPosition.left:
        return Offset(nodePosition.dx - 90, nodePosition.dy - 15);
    }
  }

  TextSpan getDirectionIcon(InteractionType interactionType, String text) {
    if (double.parse(text) == 0.0) return TextSpan();
    switch (interactionType) {
      case (InteractionType.vertical):
        IconData icon = (double.parse(text) > 0.0) ? Icons.north : Icons.south;
        return TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(fontFamily: icon.fontFamily, fontSize: 20));
      case (InteractionType.horizontal):
      case (InteractionType.angle):
        IconData icon = (double.parse(text) > 0.0) ? Icons.east : Icons.west;
        return TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(fontFamily: icon.fontFamily, fontSize: 20));
      default:
        return TextSpan();
    }
  }

  @override
  bool shouldRepaint(BaseSketchPainter ldDelegate) {
    return true;
  }
}
