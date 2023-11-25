import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:netourism_mobile_app/constants/constants.dart';
import 'package:netourism_mobile_app/constants/images_upload.dart';
import 'package:netourism_mobile_app/data/users_stories_data.dart';
import 'package:netourism_mobile_app/screens/main/stories/stories_screen.dart';
import 'package:netourism_mobile_app/screens/main/stories/widgets/stories_navigation_widget.dart';
import 'package:netourism_mobile_app/story_model.dart';
import 'package:netourism_mobile_app/user_stories_model.dart';
import 'package:netourism_mobile_app/widgets/choice_picker_list_widget.dart';
import 'package:netourism_mobile_app/widgets/screen_transitions_widget.dart';
import '../../../constants/secret.dart';
import '../../../models/map_marker_model.dart';
import '../../../widgets/text_form_search_field_widget.dart';
import 'package:flutter/rendering.dart';

final _mylocation = LatLng(33.7010647, -7.3621591);
final _mylocation2 = LatLng(33.70342654258918, -7.36632285713708);

final List<MapMarkerModel> markers = [
  MapMarkerModel(
    point: _mylocation,
    name: 'Marker 1',
  ),
  MapMarkerModel(
    point: _mylocation2,
    name: 'Marker 2',
  ),
  // Add more markers as needed
];

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

Future<void> getImages(LatLng location, BuildContext context) async {
  //StoriesScreen
  List<String> imagePaths = await fetchImages(LatLng(33.7011138, -7.3621081));
  print(imagePaths);
  List<Story> stories = imagePaths
      .map((e) => Story(
          url: e,
          media: MediaType.image,
          duration: const Duration(seconds: 10),
          publishedAt: DateTime.parse("2023-11-11T09:00:00")))
      .toList();

  UserStories userStories = UserStories(
      stories: stories,
      userId: 'userId',
      userName: 'userName',
      userImgUrl: 'https://randomuser.me/api/portraits/men/35.jpg');

  Navigator.of(context).push(
    SlideLeftRouteWidget(
      //StoriesScreen(userStories: userStories)
      GroupStories(userStories: userStories),
    ),
  );
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 16,
              zoom: 13,
              center: _mylocation,
              onTap: (tapPosition, point) async {
                debugPrint("lat: ${point.latitude}, long: ${point.longitude}");

                await getImages(point, context);
              },
            ),
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
                    width: 50,
                    height: 50,
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
                    width: 100,
                    height: 100,
                    point: _mylocation2,
                    builder: (context) {
                      return Container(
                        height: 100,
                        child: Image.asset(
                          "assets/images/marker.png",
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
          Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                height: 200,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.0)
                    ])),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    TextFormSearchStyledWidget(
                      icon: Icons.search,
                      label: 'Chercher',
                      placeholder: 'Chercher',
                      validator: () => {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ChoicePickerList(list: contentTypeList, isWrraped: false)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
