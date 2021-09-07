import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skm_services/components/sk_text_field.dart';
import 'package:skm_services/styles.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _customerFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: SkColors.main700,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/icons/logo_white_small.svg',
          height: 35,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              SkColors.main700,
              SkColors.main600,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.6, 1],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MediaQuery.of(context).size.width < 700
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: [
                    FormBuilder(
                      key: _customerFormKey,
                      child: Expanded(
                        child: Column(
                          children: [
                            SkTextField(
                              name: "name",
                              label: "Name",
                              optional: true,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SkTextField(
                              name: "kunden_nr",
                              label: "Kundennummer",
                              optional: false,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SkButton(
                                  onTap: () {
                                    _customerFormKey.currentState?.save();
                                    print(_customerFormKey.currentState?.value);
                                  },
                                  child: Text(
                                    "Weiter",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 28),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
