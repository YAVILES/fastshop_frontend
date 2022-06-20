import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.validator,
    this.obscureText,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  String? Function(String?)? validator;
  bool? obscureText;
  void Function(String)? onFieldSubmitted;
  void Function(String?)? onSaved;
  void Function(String)? onChanged;
  String? initialValue;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,
      onFieldSubmitted: (value) => widget.onFieldSubmitted != null
          ? widget.onFieldSubmitted!(value)
          : null,
      onSaved: (value) =>
          widget.onSaved != null ? widget.onSaved!(value) : null,
      onChanged: (value) =>
          widget.onChanged != null ? widget.onChanged!(value) : null,
    );
  }
}
