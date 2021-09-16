import 'package:flutter/material.dart';
import 'package:skm_services/styles.dart';

class SkImageButton extends StatelessWidget {
  final String _text;
  final ImageProvider<Object> _image;

  const SkImageButton({
    required String text,
    required ImageProvider<Object> image,
  })  : _text = text,
        _image = image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(
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
      ),
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
    );
  }
}
