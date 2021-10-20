import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/enums/template_type.dart';
import 'package:skm_services/features/customer/presentation/painter/rect_painter.dart';
import 'package:skm_services/features/sketch/presentation/bloc/sketch_bloc.dart';
import 'package:skm_services/models/sketch_template.dart';
import 'package:skm_services/styles.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skm_services/dependencies.dart';

class SketchScreenWrapper extends StatelessWidget {
  const SketchScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SketchBloc>(
      create: (_) => get<SketchBloc>(),
      child: SketchScreen(),
    );
  }
}

class SketchScreen extends StatefulWidget {
  @override
  _SketchScreenState createState() => _SketchScreenState();
}

class _SketchScreenState extends State<SketchScreen> {
  final GlobalKey stackKey = GlobalKey();

  @override
  void initState() {
    context.read<SketchBloc>().add(SketchLoadTemplate(type: TemplateType.One));
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

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
                return (state is SketchLoaded)
                    ? Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: SizedBox.expand(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (detail) {
                              print(detail.localPosition.dx);
                              print(detail.localPosition.dy);
                            },
                            onLongPressDown: (detail) {
                              print(detail.localPosition.dx);
                              print(detail.localPosition.dy);
                            },
                            child: AnimatedContainer(
                              color: Colors.transparent,
                              duration: Duration(seconds: 1),
                              child: CanvasTouchDetector(
                                builder: (context) => CustomPaint(
                                  painter: RectPainter(
                                    context,
                                    state.template,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
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
          title: Text("My Super title"),
          content: TextField(controller: _controller),
          actions: [
            TextButton(
                child: Text('Ok'),
                onPressed: () {
                  context.read<SketchBloc>().add(
                        SketchUpdateProperties(
                          SketchTemplate.copy(
                            state.template,
                            state.coordinateIndex,
                            double.parse(_controller.value.text),
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
}
