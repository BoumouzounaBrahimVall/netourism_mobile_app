import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/models/choice_model.dart';

class CacheVariableNames {
  static const String isConnected = 'isConnected';
  static const String token = 'token';
}

const baseUrl = "";

List<ChoiceModel> contentTypeList = [
  ChoiceModel(name: "All", index: 0, isSelected: false),
  ChoiceModel(name: "Stories", index: 0, isSelected: false),
  ChoiceModel(name: "Store", index: 0, isSelected: false),
];

class AppColor {
  static Color primaryColor = Color(0xffEE9321);
}
