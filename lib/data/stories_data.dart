import '../story_model.dart';

// this variable is just for testing purpose for story published DateTime
const String date = '2023-05-05';

final List<Story> stories = [
  Story(
      url:
          'https://images.unsplash.com/photo-1648484859960-97a7c372d8d0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      media: MediaType.image,
      duration: const Duration(
        seconds: 10,
      ),
      publishedAt: DateTime.parse("${date}T09:00:00")),
  Story(
    url:
        'https://images.unsplash.com/photo-1531986627054-7f294d095acd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    media: MediaType.image,
    duration: const Duration(
      seconds: 7,
    ),
    publishedAt: DateTime.parse("${date}T10:30:00"),
  ),
  Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    media: MediaType.video,
    duration: const Duration(
      seconds: 0,
    ),
    publishedAt: DateTime.parse("${date}T07:45:00"),
  ),
  Story(
    url:
        'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(
      seconds: 5,
    ),
    publishedAt: DateTime.parse("${date}T12:00:00"),
  ),
  Story(
    url:
        'https://agenceapicorp.com/wp-content/uploads/agostini/AGOSTINI_YOUTUBE.mp4',
    media: MediaType.video,
    duration: const Duration(
      seconds: 0,
    ),
    publishedAt: DateTime.parse("${date}T01:00:00"),
  ),
  Story(
    url:
        'https://images.unsplash.com/photo-1626632294678-aca8c0e1c368?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    media: MediaType.image,
    duration: const Duration(
      seconds: 8,
    ),
    publishedAt: DateTime.parse("${date}T04:30:00"),
  ),
];
