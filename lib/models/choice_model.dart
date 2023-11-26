import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ChoiceModel {
  ChoiceModel(
      {required this.name,
      this.icon,
      this.onTap,
      this.location,
      required this.index,
      required this.isSelected});
  String name;
  LatLng? location;
  IconData? icon;
  Function? onTap;
  int index;
  bool isSelected;
}
