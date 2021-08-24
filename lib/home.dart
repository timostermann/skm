import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/sk_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/kabine.jpeg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0x80000000),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xf8212728),
                    Color(0xff000000),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(1000, 200),
                  bottomRight: Radius.elliptical(1000, 200),
                ),
              ),
              height: 250,
              width: double.infinity,
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo_white.svg',
                      height: 130,
                    ),
                    SkButton()
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
