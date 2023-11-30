import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/models/choice_model.dart';

class CacheVariableNames {
  static const String isConnected = 'isConnected';
  static const String token = 'token';
  static const String fullName = 'fullName';
  static const String email = 'email';
}

const baseUrl = "";

List<ChoiceModel> contentTypeList = [
  ChoiceModel(
      name: "My location",
      index: 0,
      isSelected: true,
      location: curentLocation),
  ChoiceModel(
      name: "Casablanca",
      index: 0,
      isSelected: false,
      location: LatLng(33.5734, -7.5983)),
  ChoiceModel(
      name: "Rabat",
      index: 0,
      isSelected: false,
      location: LatLng(34.0258, -6.8319)),
  ChoiceModel(
      name: "Fes",
      index: 0,
      isSelected: false,
      location: LatLng(34.0522, -4.9828)),
  ChoiceModel(
      name: "Marrakesh",
      index: 0,
      isSelected: false,
      location: LatLng(31.6333, -8.01088)),
  ChoiceModel(
      name: "Tangier",
      index: 0,
      isSelected: false,
      location: LatLng(35.7791, -5.8174)),
  ChoiceModel(
      name: "Agadir",
      index: 0,
      isSelected: false,
      location: LatLng(30.4244, -9.6208)),
  ChoiceModel(
      name: "Meknes",
      index: 0,
      isSelected: false,
      location: LatLng(34.0914, -5.5739)),
  ChoiceModel(
      name: "Oujda",
      index: 0,
      isSelected: false,
      location: LatLng(34.6908, -1.9158)),
  ChoiceModel(
      name: "Laayoune",
      index: 0,
      isSelected: false,
      location: LatLng(27.1231, -13.1586)),
  ChoiceModel(
      name: "Al Hoceima",
      index: 0,
      isSelected: false,
      location: LatLng(35.2181, -3.8675)),
];

class AppColor {
  static Color primaryColor = const Color(0xffEE9321);
}
