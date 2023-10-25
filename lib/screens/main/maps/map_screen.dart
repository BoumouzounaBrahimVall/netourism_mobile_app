import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../constants/secret.dart';

final _mylocation = LatLng(33.7010647, -7.3621591);
final _mylocation2 = LatLng(33.70342654258918, -7.36632285713708);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("map test"),
      ),
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(
              minZoom: 5, maxZoom: 16, zoom: 13, center: _mylocation),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/brahimvall/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: const {
                "accessToken": mapboxAccessToken,
                "id": mapboxStyle
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _mylocation,
                  builder: (context) {
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 156, 145),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3)),
                    );
                  },
                ),
                Marker(
                  point: _mylocation2,
                  builder: (context) {
                    return Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage(
                        "assets/images/marker.png",
                      ))),
                    );
                  },
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
