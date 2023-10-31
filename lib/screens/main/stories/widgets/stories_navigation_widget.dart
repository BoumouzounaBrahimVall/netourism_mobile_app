import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '/user_stories_model.dart';
import '../stories_screen.dart';
import '../../../../../../../../data/users_stories_data.dart';

class GroupStories extends StatefulWidget {
  final int initialPage;
  final List<String> usersIds;
  const GroupStories(
      {super.key, required this.usersIds, required this.initialPage});
  @override
  State<GroupStories> createState() => _GroupStoriesState();
}

class _GroupStoriesState extends State<GroupStories>
    with SingleTickerProviderStateMixin {
  late PageController? _pageController;
  final _pageNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Add a post-frame callback to the _pageController object to listen for page changes
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _pageController!.addListener(_listener);
    });
  }

  // Define a listener method that updates the _pageNotifier object with the current page index
  void _listener() {
    _pageNotifier.value = _pageController!.page!;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ValueListenableBuilder<double>(
            valueListenable:
                _pageNotifier, // Listen to changes in _pageNotifier

            builder: (_, value, child) {
              return PageView.builder(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.usersIds.length,
                  itemBuilder: (context, index) {
                    UserStories userStories =
                        getUserStoriesById(widget.usersIds[index]);
                    final StoriesScreen story =
                        StoriesScreen(userStories: userStories);
                    // Calculate the rotation angle based on the current page index and scrolling direction
                    final isLeaving = (index - value) <= 0;
                    final t = (index - value);
                    final rotationY = lerpDouble(0, 90, t);
                    // Create a transform matrix that applies the 3D perspective effect based on the rotation angle
                    final transform = Matrix4.identity();
                    transform.setEntry(3, 2, 0.003);
                    transform.rotateY(double.parse('${-degToRad(rotationY!)}'));
                    return Transform(
                      alignment: isLeaving
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      transform: transform,
                      child: Stack(children: <Widget>[story]),
                    );
                  });
            }),
      ),
    );
  }

  // Define  a utility method to convert degrees to radians
  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void dispose() {
    _pageController!.removeListener(_listener);
    _pageController!.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }
}
