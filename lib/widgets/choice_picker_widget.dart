import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/choice_model.dart';

class ChoicePickerWidget extends StatefulWidget {
  ChoicePickerWidget({required this.data, Key? key}) : super(key: key);
  ChoiceModel data;

  @override
  State<ChoicePickerWidget> createState() => _ChoicePickerWidgetState();
}

class _ChoicePickerWidgetState extends State<ChoicePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selectedColor: AppColor.primaryColor,
      labelPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.data.icon != null
              ? Icon(widget.data.icon,
                  color: widget.data.isSelected
                      ? Colors.white
                      : AppColor.primaryColor)
              : const SizedBox(
                  width: 0,
                ), // Add your icon here
          const SizedBox(width: 8.0), // Adjust spacing between icon and text
          Text(
            widget.data.name,
            style: Theme.of(context).textTheme.bodyMedium!.merge(TextStyle(
                color: widget.data.isSelected
                    ? Colors.white
                    : AppColor.primaryColor,
                fontSize: 16)),
          ),
        ],
      ),
      shape: StadiumBorder(
        side: BorderSide(
          width: 1,
          color: AppColor.primaryColor,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 6.0,
      shadowColor: Colors.white,
      padding: const EdgeInsets.all(10.0),
      selected: widget.data.index == 1,
      onSelected: (bool selected) {
        setState(() {
          widget.data.index = selected ? 1 : 0;

          widget.data.isSelected = !widget.data.isSelected;
        });
      },
    );
  }
}
