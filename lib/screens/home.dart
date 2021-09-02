import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:skm_services/screens/customer_screen.dart';
import 'package:skm_services/styles.dart';

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
            fit: BoxFit.cover,
          ),
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
                    SkColors.main700,
                    Colors.black,
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
                margin: EdgeInsets.only(bottom: 75, top: 30),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo_white.svg',
                      height:
                          MediaQuery.of(context).size.width < 700 ? 130 : 160,
                    ),
                    SkButton(
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          print(MediaQuery.of(context).size.width);
                          return CustomerScreen();
                        }),
                      ),
                    ),
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
