import 'package:latlong2/latlong.dart';

enum MarkersType { story, store }

class MapMarkerModel {
  MapMarkerModel(
      {required this.point, required this.name, this.pathImage, this.type});
  LatLng point;
  String name;
  String? pathImage;
  MarkersType? type;
}
