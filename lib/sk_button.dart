import 'package:flutter/material.dart';

class SkButton extends StatelessWidget {
  final void Function()? _onTap;
  final Widget _child;

  SkButton({required onTap, required child})
      : _onTap = onTap,
        _child = child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          gradient: LinearGradient(
              colors: [
                Color(0xff8fa3aa),
                Color(0xffbcc8cb),
                Color(0xffdde3e6),
              ],
              begin: Alignment.center,
              end: Alignment.topRight,
              stops: [0, 0.7, 1]),
        ),
        alignment: Alignment.center,
        child: _child,
      ),
    );
  }
}
