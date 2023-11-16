import 'package:flutter/material.dart';

import '../models/choice_model.dart';
import 'choice_picker_widget.dart';

class ChoicePickerList extends StatefulWidget {
  ChoicePickerList({required this.list, required this.isWrraped, Key? key})
      : super(key: key);
  List<ChoiceModel> list;
  bool isWrraped;

  @override
  _ChoicePickerListState createState() => _ChoicePickerListState();
}

class _ChoicePickerListState extends State<ChoicePickerList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return widget.isWrraped
        ? Wrap(
            direction: Axis.horizontal,
            spacing: 3.0, //
            children: <Widget>[
              ...widget.list.map(
                (choice) {
                  return Container(
                    //   width: width * 0.4,
                    padding: EdgeInsets.all(8),
                    child: ChoicePickerWidget(
                      data: choice,
                    ),
                  );
                },
              ).toList()
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 4.0, //
              children: <Widget>[
                ...widget.list.map(
                  (choice) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: ChoicePickerWidget(
                        data: choice,
                      ),
                    );
                  },
                ).toList()
              ],
            ));
  }
}
