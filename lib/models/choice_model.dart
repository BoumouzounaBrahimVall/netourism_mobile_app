import 'package:flutter/material.dart';

class ChoiceModel {
  ChoiceModel(
      {required this.name,
      this.icon,
      this.onTap,
      required this.index,
      required this.isSelected});
  String name;
  IconData? icon;
  Function? onTap;
  int index;
  bool isSelected;
}
