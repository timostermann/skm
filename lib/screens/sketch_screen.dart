import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sketch_components/drag_node.dart';
import 'package:skm_services/styles.dart';

class SketchScreen extends StatefulWidget {
  @override
  _SketchScreenState createState() => _SketchScreenState();
}

class _SketchScreenState extends State<SketchScreen> {
  var _x = 15.0;
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
      body: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
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
              left: _x,
              top: _y,
              child: Draggable(
                feedback: DragNode(SkColors.main500, SkColors.main800),
                child: DragNode(SkColors.main500, SkColors.main800),
                childWhenDragging: DragNode(SkColors.main500, SkColors.main500),
                onDragEnd: (dragDetails) {
                  setState(() {
                    final parentPos = stackKey.globalPaintBounds;
                    if (parentPos != null) {
                      _x = dragDetails.offset.dx - parentPos.left;
                      _y = dragDetails.offset.dy - parentPos.top;
                    }
                  });
                },
              ),
            ),
          ],
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
