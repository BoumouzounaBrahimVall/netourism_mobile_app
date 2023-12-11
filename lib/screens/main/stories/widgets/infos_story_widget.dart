import 'package:flutter/material.dart';

class InfosStoryWidget extends StatelessWidget {
  final String userPicture;
  final String userName;
  final String timestamp;
  const InfosStoryWidget(
      {Key? key,
      required this.userPicture,
      required this.userName,
      required this.timestamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(
            userPicture,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                timestamp,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => print("object")),
        IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
