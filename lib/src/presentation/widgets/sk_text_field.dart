import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skm_services/src/config/styles.dart';

class SkTextField extends StatelessWidget {
  final String _name;
  final String _label;
  final bool _optional;
  final String? Function(String?)? _validator;
  final bool _last;
  final TextInputType _keyboardType;
  final String? _initialValue;

  const SkTextField(
      {required String name,
      required String label,
      bool optional = false,
      String? Function(String?)? validator,
      bool last = false,
      TextInputType keyboardType = TextInputType.text,
      String? initialValue})
      : _name = name,
        _label = label,
        _optional = optional,
        _validator = validator,
        _last = last,
        _keyboardType = keyboardType,
        _initialValue = initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: _name,
        cursorColor: SkColors.main500,
        style: TextStyle(
          color: SkColors.main300,
          fontSize: 20.0,
        ),
        initialValue: _initialValue,
        textInputAction: _last ? TextInputAction.done : TextInputAction.next,
        keyboardType: _keyboardType,
        validator: _optional
            ? _validator
            : _validator ??
                (value) {
                  if ((value?.length ?? 0) == 0) {
                    return "Bitte fülle dieses Feld aus.";
                    // return null;
                  }
                  return null;
                },
        decoration: getStyle(_label, _optional, true));
  }

  static InputDecoration getStyle(String? label, bool optional, bool filled) {
    return InputDecoration(
      filled: filled,
      fillColor: SkColors.main700,
      labelStyle: TextStyle(
        color: SkColors.main500,
      ),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color: SkColors.accent400,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        borderSide: const BorderSide(
          color: SkColors.main500,
          width: 1.0,
        ),
      ),
      suffixIcon: Text(
        optional ? "optional" : "",
        style: TextStyle(
          color: SkColors.accent400,
          fontSize: 16.0,
        ),
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: 75,
        minHeight: 0,
      ),
    );
  }
}
