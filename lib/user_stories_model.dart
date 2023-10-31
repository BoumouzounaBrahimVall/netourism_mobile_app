import '../story_model.dart';

class UserStories {
  final List<Story> stories;
  String userId;
  String userName;
  String userImgUrl;
  UserStories(
      {required this.stories,
      required this.userId,
      required this.userName,
      required this.userImgUrl});
}
