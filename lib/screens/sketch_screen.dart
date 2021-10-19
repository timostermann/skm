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
  var _x = 200.0;
  var _y = 200.0;
  var _offset = 0.0;
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
                top: 25,
                left: 30,
                child: DragLine(
                  length: _x,
                  onSubmitted: (newValue) {
                    if (double.tryParse(newValue) != null &&
                        double.tryParse(newValue)! > getWidth(context) - 100) {
                      _x = getWidth(context) - 100;
                    } else if (double.tryParse(newValue) != null &&
                        double.tryParse(newValue)! < 100) {
                      _x = 100;
                    } else {
                      _x = double.tryParse(newValue) ?? _x;
                    }
                  },
                ),
              ),
              Positioned(
                top: 25,
                left: _x + 25,
                child: DragLine(
                  isVertical: true,
                  length: _y,
                  onSubmitted: (newValue) {
                    if (double.tryParse(newValue) != null &&
                        double.tryParse(newValue)! > getHeight(context) - 200) {
                      _y = getHeight(context) - 200;
                    } else if (double.tryParse(newValue) != null &&
                        double.tryParse(newValue)! < 100) {
                      _y = 100;
                    } else {
                      _y = double.tryParse(newValue) ?? _x;
                    }
                  },
                ),
              ),
              Positioned(
                top: 25,
                left: 30,
                child: DragLine(
                  isVertical: true,
                  length: _y - 10,
                  hasInput: false,
                ),
              ),
              Positioned(
                top: _y + 10,
                left: _offset,
                child: DragLine(
                  length: _x - _offset + 25,
                  hasInput: false,
                ),
              ),
              Positioned(
                left: _x + 15,
                top: 15,
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
                            getWidth(context) - 100) {
                          _x = getWidth(context) - 100;
                        } else if (dragUpdateDetails.localPosition.dx -
                                parentPos.left <
                            100) {
                          _x = 100;
                        } else {
                          _x = dragUpdateDetails.localPosition.dx - 15;
                        }
                      }
                    });
                  },
                ),
              ),
              Positioned(
                left: _x + 15,
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
                        if (dragUpdateDetails.localPosition.dy - parentPos.top >
                            getHeight(context) - 200) {
                          _y = getHeight(context) - 200;
                        } else if (dragUpdateDetails.localPosition.dy -
                                parentPos.top <
                            100) {
                          _y = 100;
                        } else {
                          print(dragUpdateDetails.localPosition.dy);
                          print(parentPos.top);
                          print(getHeight(context));
                          // TODO wieso -95 nötig?
                          _y = dragUpdateDetails.localPosition.dy - 100;
                        }
                      }
                    });
                  },
                ),
              ),
              Positioned(
                left: _offset,
                top: _y,
                child: Draggable(
                  feedback: Container(),
                  child: DragNode(SkColors.main500, SkColors.main800),
                  childWhenDragging:
                      DragNode(SkColors.main400, SkColors.main800),
                  onDragUpdate: (dragUpdateDetails) {
                    setState(() {
                      final parentPos = stackKey.globalPaintBounds;
                      print(dragUpdateDetails.localPosition.dx);
                      if (parentPos != null) {
                        if (dragUpdateDetails.localPosition.dx - 15 > 200) {
                          _offset = 200;
                        } else if (dragUpdateDetails.localPosition.dx - 15 <
                            0) {
                          _offset = 0;
                        } else {
                          _offset = dragUpdateDetails.localPosition.dx - 15;
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
