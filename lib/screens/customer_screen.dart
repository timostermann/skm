import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skm_services/components/sk_text_field.dart';
import 'package:skm_services/globals.dart';
import 'package:skm_services/screens/home.dart';
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
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 32,
                      left: 12,
                    ),
                    child: Text(
                      "Kundendaten",
                      style: TextStyle(
                        color: SkColors.main300,
                        fontSize: isTablet(context) ? 36 : 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                      left: 12,
                    ),
                    child: Text(
                      "Bitte geben Sie zunächst die Kundendaten ein.",
                      style: TextStyle(
                        color: SkColors.main300,
                        fontSize: isTablet(context) ? 16 : 20,
                      ),
                    ),
                  ),
                  FormBuilder(
                    key: _customerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: isTablet(context)
                          ? [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: SkTextField(
                                        name: "first-name",
                                        label: "Vorname",
                                        optional: false,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    Flexible(
                                      child: SkTextField(
                                        name: "last-name",
                                        label: "Nachname",
                                        optional: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "street",
                                label: "Straße & Hausnummer",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: SkTextField(
                                        name: "postcode",
                                        label: "PLZ",
                                        optional: false,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: SkTextField(
                                        name: "place",
                                        label: "Wohnort",
                                        optional: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "phone",
                                label: "Telefonnummer",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "email",
                                label: "E-Mail-Adresse",
                                optional: true,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "kunden_nr",
                                label: "Kundennummer",
                                optional: false,
                                last: true,
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
                                      print(
                                          _customerFormKey.currentState?.value);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return Home();
                                        }),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: SvgPicture.asset(
                                            "assets/icons/circled_tick.svg",
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
                                  ),
                                ],
                              ),
                            ]
                          : [
                              SkTextField(
                                name: "first-name",
                                label: "Vorname",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "last-name",
                                label: "Nachname",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "street",
                                label: "Straße & Hausnummer",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "postcode",
                                label: "PLZ",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "place",
                                label: "Wohnort",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "phone",
                                label: "Telefonnummer",
                                optional: false,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "email",
                                label: "E-Mail-Adresse",
                                optional: true,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "kunden_nr",
                                label: "Kundennummer",
                                optional: false,
                                last: true,
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
                                      print(
                                          _customerFormKey.currentState?.value);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
