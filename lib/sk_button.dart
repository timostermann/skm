import 'package:flutter/material.dart';

class SkButton extends StatelessWidget {
  const SkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("jabadabaduh"),
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xff8fa3aa),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        alignment: Alignment.center,
        child: Text(
          "Start",
          style: TextStyle(color: Colors.white, fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
