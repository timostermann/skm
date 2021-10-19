import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sketch_components/position_controller.dart';
import 'package:skm_services/styles.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';

import '../components/sketch_components/sketch_painter.dart';

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
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: SizedBox.expand(
                child: ChangeNotifierProvider<PaintingController>(
                  create: (context) => PaintingController(),
                  child: Consumer<PaintingController>(
                    builder: (context, controller, child) => AnimatedContainer(
                      color: Colors.transparent,
                      duration: Duration(seconds: 1),
                      child: CanvasTouchDetector(
                        builder: (context) =>
                            CustomPaint(painter: SketchPainter(context)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
