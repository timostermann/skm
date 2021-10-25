import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skm_services/components/sk_image_button.dart';
import 'package:skm_services/enums/template_type.dart';
import 'package:skm_services/globals.dart';
import 'package:skm_services/styles.dart';

class ScenarioScreen extends StatefulWidget {
  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  final _customerFormKey = GlobalKey<FormBuilderState>();

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
        child: SizedBox.expand(
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
                        "Einbausituation",
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
                        "Bitte wählen Sie eine passende Einbausituation.",
                        style: TextStyle(
                          color: SkColors.main300,
                          fontSize: isTablet(context) ? 16 : 20,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: FormBuilder(
                        key: _customerFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: isTablet(context)
                              ? [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SkImageButton(
                                        text: "Nische",
                                        image: AssetImage(
                                            'assets/images/nische.jpg'),
                                        type: TemplateType.Alcove,
                                      ),
                                      SkImageButton(
                                        text: "Ecke",
                                        image: AssetImage(
                                            'assets/images/ecke.jpg'),
                                        type: TemplateType.Corner,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SkImageButton(
                                        text: "Badewanne",
                                        image: AssetImage(
                                            'assets/images/badewanne.jpg'),
                                        type: TemplateType.Tub,
                                      ),
                                      SkImageButton(
                                        text: "Freistehend",
                                        image: AssetImage(
                                            'assets/images/freistehend.jpg'),
                                        type: TemplateType.Free,
                                      ),
                                    ],
                                  ),
                                ]
                              : [
                                  SkImageButton(
                                    text: "Nische",
                                    image:
                                        AssetImage('assets/images/nische.jpg'),
                                    type: TemplateType.Alcove,
                                  ),
                                  SkImageButton(
                                    text: "Ecke",
                                    image: AssetImage('assets/images/ecke.jpg'),
                                    type: TemplateType.Corner,
                                  ),
                                  SkImageButton(
                                    text: "Badewanne",
                                    image: AssetImage(
                                        'assets/images/badewanne.jpg'),
                                    type: TemplateType.Tub,
                                  ),
                                  SkImageButton(
                                    text: "Freistehend",
                                    image: AssetImage(
                                        'assets/images/freistehend.jpg'),
                                    type: TemplateType.Free,
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
