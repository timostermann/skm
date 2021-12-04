import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skm_services/components/sk_image_button.dart';
import 'package:skm_services/enums/template_type.dart';

void main() {
  testWidgets("finds image and text widget", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SkImageButton(
            text: "Ecke",
            image: AssetImage('assets/images/ecke.jpg'),
            type: TemplateType.Corner),
      ),
    ));

    expect(find.text("Ecke"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
