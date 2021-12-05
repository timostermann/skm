import 'package:flutter/material.dart';
import 'package:skm_services/src/config/styles.dart';
import 'package:skm_services/src/data/enums/template_type.dart';
import 'package:skm_services/src/presentation/screens/sketch_screen.dart';

class SkImageButton extends StatelessWidget {
  final String _text;
  final ImageProvider<Object> _image;
  final TemplateType _type;

  SkImageButton({
    required String text,
    required ImageProvider<Object> image,
    required TemplateType type,
  })  : _text = text,
        _image = image,
        _type = type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeToSketchScreen(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: imageButtonBoxDecoration,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
              child: Image(
                height: 200,
                width: 300,
                fit: BoxFit.cover,
                image: _image,
              ),
            ),
            Container(
              width: 300,
              height: 70,
              child: Center(
                child: Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: SkColors.main300, fontSize: 28),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final BoxDecoration? imageButtonBoxDecoration = BoxDecoration(
    border: Border.all(color: SkColors.accent400, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(15)),
    color: Colors.black,
    gradient: LinearGradient(
      colors: [
        SkColors.main700,
        SkColors.main800,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.center,
    ),
  );

  void routeToSketchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SketchScreenWrapper(type: _type);
      }),
    );
  }
}
