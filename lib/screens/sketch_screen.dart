import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sketch_components/drag_node.dart';
import 'package:skm_services/components/sketch_components/drag_line.dart';
import 'package:skm_services/globals.dart';
import 'package:skm_services/styles.dart';

class SketchScreen extends StatefulWidget {
  @override
  _SketchScreenState createState() => _SketchScreenState();
}

class _SketchScreenState extends State<SketchScreen> {
  var _x = 30.0;
  var _y = 15.0;
  final GlobalKey stackKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: SkColors.main700,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/icons/logo_white_small.svg',
          height: 35,
        ),
      ),
      body: Container(
        child: InteractiveViewer(
          panEnabled: false,
          minScale: 0.5,
          constrained: true,
          maxScale: 2,
          child: Stack(
            key: stackKey,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      SkColors.main300,
                      SkColors.main400,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.6, 1],
                  ),
                ),
              ),
              Positioned(
                top: _y + 10,
                left: 15,
                child: DragLine(_x),
              ),
              Positioned(
                left: _x,
                top: _y,
                child: Draggable(
                  feedback: Container(),
                  child: DragNode(SkColors.main500, SkColors.main800),
                  childWhenDragging:
                      DragNode(SkColors.main400, SkColors.main800),
                  onDragUpdate: (dragUpdateDetails) {
                    setState(() {
                      final parentPos = stackKey.globalPaintBounds;
                      print(parentPos);
                      if (parentPos != null) {
                        if (dragUpdateDetails.localPosition.dx -
                                parentPos.left >
                            getWidth(context) - 45) {
                          _x = getWidth(context) - 45;
                        } else if (dragUpdateDetails.localPosition.dx -
                                parentPos.left <
                            15) {
                          _x = 15;
                        } else {
                          _x = dragUpdateDetails.localPosition.dx - 15;
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}
