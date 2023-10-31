import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/story_model.dart';
import 'package:netourism_mobile_app/user_stories_model.dart';
import 'package:video_player/video_player.dart';

import 'widgets/infos_story_widget.dart';
import 'widgets/progress_bar_widget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key, required this.userStories});

  final UserStories userStories;

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen>
    with SingleTickerProviderStateMixin {
  late PageController storyController;
  late AnimationController animationController;
  late List<bool> isLoadings;
  late List<Story> stories;
  VideoPlayerController? videoController;
  int currentIndex = 0;
  void onTapDown(
    TapDownDetails details,
    Story story,
  ) {
    final double width = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < width / 3) {
      setState(() {
        if (currentIndex - 1 >= 0) {
          currentIndex -= 1;
          loadStory(story: stories[currentIndex], loadingIndex: currentIndex);
        }
      });
    } else if (dx > 2 * width / 3) {
      setState(
        () {
          if (currentIndex + 1 < stories.length) {
            currentIndex += 1;
            loadStory(story: stories[currentIndex], loadingIndex: currentIndex);
          } else {
            currentIndex = 0;
            loadStory(story: stories[currentIndex], loadingIndex: currentIndex);
            //Navigator.of(context).pop(); //TODO: last story needs to pop the screen
          }
        },
      );
    } else {
      if (story.media == MediaType.video) {
        if (videoController!.value.isPlaying) {
          videoController?.pause();
          animationController.stop();
        } else {
          videoController?.play();
          animationController.forward();
        }
      }
    }
  }

  void loadStory({
    required Story story,
    bool animateToPage = true,
    required int loadingIndex,
  }) {
    animationController.stop();
    animationController.reset();

    videoController?.pause();
    videoController = null;
    videoController?.dispose();
    switch (story.media) {
      case MediaType.image:
        animationController.duration = story.duration;
        animationController.forward();
        break;
      case MediaType.video:
        videoController = VideoPlayerController.network(story.url)
          ..initialize().then(
            (_) {
              setState(() {
                // rerender the widgetTree to visualize the video
                isLoadings[loadingIndex] = false;
              });
              if (videoController!.value.isInitialized) {
                animationController.duration = videoController!.value.duration;
                videoController?.play();
                animationController.forward();
              }
            },
          );
        break;
    }
    if (animateToPage) {
      storyController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    storyController = PageController();
    animationController = AnimationController(vsync: this);
    stories = widget.userStories.stories;
    final Story firstStory = stories.first;
    isLoadings = List.filled(stories.length, true);
    loadStory(story: firstStory, animateToPage: false, loadingIndex: 0);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.stop();
        animationController.reset();
        setState(() {
          if (currentIndex + 1 < stories.length) {
            currentIndex += 1;
            loadStory(story: stories[currentIndex], loadingIndex: currentIndex);
          } else {
            currentIndex = 0;
            loadStory(story: stories[currentIndex], loadingIndex: currentIndex);
            // Navigator.of(context).pop();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Declarations
    final Story story = stories[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (details) => onTapDown(details, story),
            child: PageView.builder(
              controller: storyController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (context, i) {
                final Story story = stories[i];
                switch (story.media) {
                  case MediaType.image:
                    return CachedNetworkImage(
                      imageUrl: story.url,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      placeholder: (context, url) => Container(
                        color: Colors.white,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      // TODO: Change picture
                      errorWidget: (context, url, error) => Image.asset(
                        "AppConstants.logoTitle",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  case MediaType.video:
                    if (isLoadings[i]) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else if (videoController != null &&
                        videoController!.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: videoController!.value.size.width,
                          height: videoController!.value.size.height,
                          child: VideoPlayer(videoController!),
                        ),
                      );
                    }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 5, 24, 40),
                        Color.fromARGB(255, 5, 24, 40).withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: stories
                              .asMap()
                              .map((i, e) {
                                return MapEntry(
                                  i,
                                  ProgressBarWidget(
                                    animController: animationController,
                                    position: i,
                                    currentIndex: currentIndex,
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.5,
                            vertical: 10.0,
                          ),
                          child: InfosStoryWidget(
                            userPicture: widget.userStories.userImgUrl,
                            // "https://randomuser.me/api/portraits/men/45.jpg",
                            userName: widget.userStories.userName,
                            timestamp: widget
                                .userStories.stories[currentIndex].timestamp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                if (story.media == MediaType.video) {
                  if (videoController!.value.isPlaying) {
                    videoController?.pause();
                  }
                }
                animationController.stop();
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromARGB(255, 5, 24, 40),
                          Color.fromARGB(255, 5, 24, 40).withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          left: 10.0,
                          right: 10.0,
                          bottom: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "A wonderful moments we're living",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Riad Essalam - Mohammedia",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const FeatherIcon(FeatherIcons.heart))
                          ],
                        )),
                  )
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 1.5,
              //     vertical: 10.0,
              //   ),
              //   child: MessageInputWidget(),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    storyController.dispose();
    animationController.dispose();
    videoController?.dispose();
    super.dispose();
  }

  TextEditingController textEditingController = TextEditingController();
  bool isComposingMessage = false;
  Widget messageInput(double width, VoidCallback onTap) {
    return Container(
        width: width,
        constraints: const BoxConstraints(maxHeight: 40 * 4, minHeight: 60),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white)
              // color: AppColors.colorWhite,
              ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: onTap,
                  scrollPadding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  maxLines: 5,
                  minLines: 1,
                  style: TextStyle(color: Colors.white),
                  controller: textEditingController,
                  onChanged: (text) {
                    setState(() {
                      isComposingMessage = text.trim().isNotEmpty;
                    });
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              if (isComposingMessage)
                IconButton(
                  padding: const EdgeInsets.all(10),
                  alignment: AlignmentDirectional.center,
                  constraints: const BoxConstraints(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const FeatherIcon(
                    FeatherIcons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Code to send the message
                    String message = textEditingController.text;
                    // widget.onSendclick(message);
                    // Reset the text field
                    textEditingController.clear();
                    setState(() {
                      isComposingMessage = false;
                    });
                    // Add your logic to handle the sent message here
                  },
                ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ));
  }
}
