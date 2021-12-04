import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:skm_services/globals.dart';
import 'package:skm_services/features/customer/presentation/page/customer_screen.dart';
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
                      height: isTablet(context) ? 130 : 160,
                    ),
                    SkButton(
                      child: Stack(children: [
                        Center(
                          child: Text(
                            "Start",
                            style: TextStyle(color: Colors.white, fontSize: 28),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                      onTap: () {
                        routeToCustomerScreen(context);
                      },
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

  void routeToCustomerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CustomerScreen();
      }),
    );
  }
}
