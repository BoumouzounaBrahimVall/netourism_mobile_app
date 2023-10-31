import 'dart:async';
import '../screens/main/stories/methods/format_story_timespam_method.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  late String timestamp;
  DateTime publishedAt;

  Story(
      {required this.url,
      required this.media,
      required this.duration,
      required this.publishedAt}) {
    updateTimestamp();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      updateTimestamp();
    });
  }
  void updateTimestamp() {
    timestamp = formatStoryTimestamp(publishedAt);
  }
}
