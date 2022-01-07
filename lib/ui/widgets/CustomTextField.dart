import 'package:fabrishop/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Function(String) validator;
  final String inputFormatters;
  final bool isSecure;
  final TextInputType inputType;
  final double fontSize;
  final IconData suffixIcon;
  final TextEditingController controller;

  const CustomTextField(
      {Key key,
      @required this.label,
      this.inputFormatters,
      this.validator,
      this.isSecure = false,
      this.inputType = TextInputType.text,
      this.fontSize = 17,
      this.controller,
      this.suffixIcon})
      : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.isSecure,
      inputFormatters: widget.inputFormatters != null
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(widget.inputFormatters)),
            ]
          : null,
      validator: widget.validator,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: primary),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColorSecondary, width: 1),
        ),
        border: OutlineInputBorder(),
        labelText: widget.label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          fontSize: widget.fontSize,
        ),
        suffixIcon: Icon(widget.suffixIcon),
        //contentPadding: EdgeInsets.symmetric(vertical: 10)
      ),
    );
  }
}
