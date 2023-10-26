import 'package:flutter/material.dart';

class FieldModel {
  FieldModel(
      {this.label,
      this.placeholder,
      this.controller,
      this.icon,
      this.onChanged,
      this.validator,
      this.isPassword});
  String? label;
  String? placeholder;
  TextEditingController? controller;
  IconData? icon;
  Function? validator;
  Function? onChanged;
  String? errorString;
  bool? isPassword;
}
