import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:netourism_mobile_app/constants/current_location.dart';
import 'package:netourism_mobile_app/widgets/toast_widget.dart';
import '/constants/constants.dart';
import '/services/events/images_upload.dart';
import '/screens/main/stories/widgets/stories_navigation_widget.dart';
import '/story_model.dart';
import '/user_stories_model.dart';
import '/widgets/choice_picker_list_widget.dart';
import '/widgets/screen_transitions_widget.dart';
import '../../../constants/secret.dart';
import '../../../models/map_marker_model.dart';
import '../../../widgets/text_form_search_field_widget.dart';

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

class _MapScreenState extends State<MapScreen> {
  final mapController = MapController();
  late LatLng centerLocation;
  List<LatLng> eventLocations = [];

  double currentZoom = 11;
  @override
  void initState() {
    super.initState();
    centerLocation = _mylocation;
  }

  Future<void> getImages(LatLng location, BuildContext context) async {
    //StoriesScreen
    List<String> imagePaths =
        await fetchImages(location); //LatLng(33.7011138, -7.3621081)
    if (imagePaths.isEmpty) {
      ToastWidget.showToast(context: context, text: "Oups! no event to show");
      return;
    }
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

  void zoomOut() {
    currentZoom = currentZoom - 1;
    mapController.move(centerLocation, currentZoom);
  }

  void zoomInt() {
    currentZoom = currentZoom + 1;
    mapController.move(centerLocation, currentZoom);
  }

  Future<void> getCurentEventsLocations() async {
    eventLocations = await fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Container(
        width: 70,
        margin: const EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: zoomInt,
                child: const Text(
                  "+",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )),
            const Text(
              "|",
              style: TextStyle(color: Colors.white),
            ),
            GestureDetector(
                onTap: zoomOut,
                child: const Text(
                  "-",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ))
          ],
        ),
      ),
      body: FutureBuilder(
        future: getCurentEventsLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("loading..."),
            );
          } else {
            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    minZoom: 5,
                    maxZoom: 16,
                    zoom: 11,
                    center: centerLocation,
                    onTap: (tapPosition, point) async {
                      debugPrint(
                          "lat: ${point.latitude}, long: ${point.longitude}");

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
                      markers: eventLocations
                          .map(
                            (e) => Marker(
                              point: e,
                              width: 10,
                              height: 10,
                              builder: (context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 32, 156, 145),
                                    shape: BoxShape.circle,
                                    // border: Border.all(color: Colors.white, width: 3)
                                  ),
                                );
                              },
                            ),
                          )
                          .toList()
                      /*
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
                      return SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/images/marker.png",
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  )
                */
                      ,
                    )
                  ],
                ),
                Positioned(
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormSearchStyledWidget(
                            icon: Icons.search,
                            label: 'Chercher',
                            placeholder: 'Chercher',
                            validator: () => {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ChoicePickerList(
                            list: contentTypeList,
                            isWrraped: false,
                            action: (a) {
                              centerLocation = a.location!;
                              mapController.move(a.location!, 11);
                            },
                          )
                        ],
                      ),
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
