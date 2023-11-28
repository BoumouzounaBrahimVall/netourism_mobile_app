import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/constants/constants.dart';

import '../models/choice_model.dart';
import 'choice_picker_widget.dart';

class ChoicePickerList extends StatefulWidget {
  ChoicePickerList(
      {required this.list, required this.isWrraped, Key? key, this.action})
      : super(key: key);
  List<ChoiceModel> list;
  Function(ChoiceModel a)? action;
  bool isWrraped;

  @override
  State<ChoicePickerList> createState() => _ChoicePickerListState();
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          for (var element in contentTypeList) {
                            element.isSelected = false;
                          }
                          choice.isSelected = true;
                        });

                        widget.action!(choice);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: choice.isSelected
                                ? AppColor.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColor.primaryColor, width: 2),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            choice.name,
                            style: TextStyle(
                                color: choice.isSelected
                                    ? Colors.white
                                    : Colors.black),
                          )),
                    );
                  },
                ).toList()
              ],
            ));
  }
}
