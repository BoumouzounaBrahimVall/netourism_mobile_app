import 'package:flutter/material.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  const ButtonPrimaryWidget(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
          ),
          minimumSize: MaterialStatePropertyAll(Size(width * 0.9, 52)),
          maximumSize: MaterialStatePropertyAll(Size(width * 0.9, 52)),
          backgroundColor: const MaterialStatePropertyAll(Color(0xffEE9321)),
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
        ),
        onPressed: () => onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.merge(
              const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
