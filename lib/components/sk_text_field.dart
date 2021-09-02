import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../styles.dart';

class SkTextField extends StatelessWidget {
  final String _name;
  final String _label;
  final bool _optional;

  const SkTextField({
    required name,
    required label,
    required optional,
  })  : _name = name,
        _label = label,
        _optional = optional;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: _name,
      cursorColor: SkColors.main500,
      style: TextStyle(
        color: SkColors.main300,
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: SkColors.main800,
        labelStyle: TextStyle(
          color: SkColors.main400,
        ),
        labelText: _label,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: SkColors.accent400,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        suffixIcon: Text(
          _optional ? "optional" : "",
          style: TextStyle(
            color: SkColors.accent400,
            fontSize: 16.0,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 75,
          minHeight: 0,
        ),
      ),
    );
  }
}
