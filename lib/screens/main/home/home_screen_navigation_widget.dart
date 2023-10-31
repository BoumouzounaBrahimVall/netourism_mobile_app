import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/screens/main/home/camera_screen.dart';
import 'package:netourism_mobile_app/screens/main/maps/map_screen.dart';
import 'package:netourism_mobile_app/screens/main/profile/profile_screen.dart';

class HomeScreenNavigationWidget extends StatefulWidget {
  const HomeScreenNavigationWidget({super.key});
  final currentScreen = 0;
  @override
  State<HomeScreenNavigationWidget> createState() =>
      _HomeScreenNavigationWidgetState();
}

class _HomeScreenNavigationWidgetState
    extends State<HomeScreenNavigationWidget> {
  late int _currentIndex;
  Color iconColor = const Color.fromARGB(255, 151, 151, 151);
  Color selectedIconColor = const Color(0xffEE9321);
  final List<Widget> _screens = [
    const MapScreen(),
    const CameraScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentScreen;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      /*  Stack(
        children: [
        ,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: height * 0.125,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.6),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
     */
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(42, 0, 10, 24),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _currentIndex == 0 ? selectedIconColor : Colors.transparent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: selectedIconColor
                      .withOpacity(_currentIndex == 0 ? 0.6 : 0),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: IconButton(
              iconSize: 32,
              icon: FeatherIcon(
                FeatherIcons.map,
                color: _currentIndex == 0 ? Colors.white : iconColor,
              ),
              onPressed: () {
                _onTabTapped(0);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _currentIndex == 1 ? selectedIconColor : Colors.transparent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: selectedIconColor
                      .withOpacity(_currentIndex == 1 ? 0.6 : 0),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: IconButton(
              iconSize: 32,
              icon: FeatherIcon(
                FeatherIcons.camera,
                color: _currentIndex == 1 ? Colors.white : iconColor,
              ),
              onPressed: () {
                _onTabTapped(1);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _currentIndex == 2 ? selectedIconColor : Colors.transparent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: selectedIconColor
                      .withOpacity(_currentIndex == 2 ? 0.6 : 0),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: IconButton(
              iconSize: 32,
              icon: FeatherIcon(
                FeatherIcons.user,
                color: _currentIndex == 2 ? Colors.white : iconColor,
              ),
              onPressed: () {
                _onTabTapped(2);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
