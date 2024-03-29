import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skm_services/src/config/styles.dart';
import 'package:skm_services/src/data/enums/template_type.dart';
import 'package:skm_services/src/data/models/sketch_template.dart';
import 'package:skm_services/src/injector.dart';
import 'package:skm_services/src/presentation/blocs/mode/mode_bloc.dart';
import 'package:skm_services/src/presentation/blocs/sketch/sketch_bloc.dart';
import 'package:skm_services/src/presentation/painter/alcove_painter.dart';
import 'package:skm_services/src/presentation/painter/corner_painter.dart';
import 'package:skm_services/src/presentation/painter/free_rect_painter.dart';
import 'package:skm_services/src/presentation/painter/tub_painter.dart';
import 'package:skm_services/src/presentation/screens/document_screen.dart';
import 'package:skm_services/src/presentation/widgets/sk_button.dart';
import 'package:skm_services/src/presentation/widgets/sk_text_field.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SketchScreenWrapper extends StatelessWidget {
  final TemplateType _type;

  const SketchScreenWrapper({
    Key? key,
    required TemplateType type,
  })  : _type = type,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SketchBloc>(
          create: (_) => get<SketchBloc>(),
        ),
        BlocProvider<ModeBloc>(
          create: (_) => get<ModeBloc>(),
        ),
      ],
      child: SketchScreen(type: _type),
    );
  }
}

class SketchScreen extends StatefulWidget {
  final TemplateType _type;

  const SketchScreen({
    required type,
  }) : _type = type;

  @override
  _SketchScreenState createState() => _SketchScreenState(type: _type);
}

class _SketchScreenState extends State<SketchScreen> {
  final GlobalKey stackKey = GlobalKey();
  final TemplateType _type;

  _SketchScreenState({
    required type,
  }) : _type = type;

  @override
  void initState() {
    context.read<SketchBloc>().add(SketchLoadTemplate(type: _type));
    super.initState();
  }

  TextEditingController _textController = TextEditingController();
  ScreenshotController _screenshotController = ScreenshotController();

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
            BlocConsumer<SketchBloc, SketchState>(
              listener: (context, state) async {
                if (state is SketchShowTextField) {
                  await showInputDialog(context, state);
                }
              },
              buildWhen: (previous, current) =>
                  (current is! SketchShowTextField),
              builder: (context, state) {
                return Screenshot(
                  controller: _screenshotController,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox.expand(
                      child: AnimatedContainer(
                        color: Colors.transparent,
                        duration: Duration(seconds: 1),
                        child: CanvasTouchDetector(
                          builder: (context) => CustomPaint(
                            painter: getPainter(_type, context, state.template),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              right: 30.0,
              bottom: 50.0,
              child: BlocBuilder<SketchBloc, SketchState>(
                builder: (context, state) {
                  return SkButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SvgPicture.asset(
                            "assets/icons/tick.svg",
                            width: 40,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: Text(
                              "Weiter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onLightBackground: true,
                    onTap: () async {
                      Uint8List? screenshotData =
                          await _screenshotController.capture();
                      if (screenshotData != null) {
                        context
                            .read<SketchBloc>()
                            .add(SketchScreenshot(screenshot: screenshotData));
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DocumentScreen(
                              painter:
                                  getPainter(_type, context, state.template));
                        }),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 50.0,
              child: BlocBuilder<ModeBloc, ModeState>(
                builder: (context, state) {
                  return SkButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            (state is InputMode) ? Icons.keyboard : Icons.swipe,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Text(
                              "Modus: " +
                                  ((state is InputMode) ? "Eingabe" : "Ziehen"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onLightBackground: true,
                    onTap: () {
                      if (state is InputMode) {
                        context.read<ModeBloc>().add(ToggleMode());
                      } else {
                        context.read<ModeBloc>().add(ToggleMode());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showInputDialog(
      BuildContext context, SketchShowTextField state) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Passe die Länge der Linie an."),
          content: TextField(
            controller: _textController,
            decoration: SkTextField.getStyle(null, false, false),
          ),
          actions: [
            TextButton(
                child: Text('Bestätigen'),
                onPressed: () {
                  context.read<SketchBloc>().add(
                        SketchUpdateProperties(
                          SketchTemplate.copy(
                            state.template,
                            state.coordinateIndex,
                            double.tryParse(_textController.value.text) ??
                                state.template.interactiveCoordinates[
                                    state.coordinateIndex],
                          ),
                        ),
                      );
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  CustomPainter? getPainter(
      TemplateType _type, BuildContext context, SketchTemplate template) {
    final Map<TemplateType, CustomPainter> painter = {
      TemplateType.Corner: CornerPainter(context, template),
      TemplateType.Free: FreeRectPainter(context, template),
      TemplateType.Tub: TubPainter(context, template),
      TemplateType.Alcove: AlcovePainter(context, template),
    };

    return painter[_type];
  }
}
