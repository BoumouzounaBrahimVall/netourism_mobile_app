import './stories_data.dart';
import '../user_stories_model.dart';

final List<UserStories> usersStories = [
  UserStories(
      stories: stories,
      userId: '0',
      userName: 'Sam Alex',
      userImgUrl: 'https://randomuser.me/api/portraits/men/30.jpg'),
  UserStories(
    stories: stories,
    userId: '1',
    userName: 'Jack Ma',
    userImgUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
  ),
  UserStories(
    stories: stories,
    userId: '2',
    userName: 'Alberto Sebastian',
    userImgUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
  ),
  UserStories(
    stories: stories,
    userId: '3',
    userName: 'Amigo Cantara',
    userImgUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
  ),
  UserStories(
    stories: stories,
    userId: '4',
    userName: 'Christian Samoel',
    userImgUrl: 'https://randomuser.me/api/portraits/men/34.jpg',
  ),
  UserStories(
    stories: stories,
    userId: '5',
    userName: 'Alexander Jackson',
    userImgUrl: 'https://randomuser.me/api/portraits/men/35.jpg',
  ),
];

// normally this methode should be async method if triggering the API
UserStories getUserStoriesById(String id) {
  final user = usersStories.firstWhere((user) => user.userId == id,
      orElse: () => // this means the user is not in the list
          UserStories(stories: [], userId: '', userName: '', userImgUrl: ''));
  return user;
}

List<String> getUserIds() {
  return usersStories.map((user) => user.userId).toList();
}
