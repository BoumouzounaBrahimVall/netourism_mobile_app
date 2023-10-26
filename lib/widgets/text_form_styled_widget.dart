import 'package:flutter/material.dart';

class TextFormStyledWidget extends StatefulWidget {
  TextFormStyledWidget({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.action,
    this.isPassword = false,
    required this.validator,
    this.decoration,
    this.obscureText,
    this.onChanged,
    this.errorText,
  }) : super(key: key);
  final String label;
  final String placeholder;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function? action;
  final bool isPassword;
  final Function validator;
  final InputDecoration? decoration;
  final bool? obscureText;
  final Function? onChanged;

  final String? errorText;
  @override
  TextFormStyledWidgetState createState() => TextFormStyledWidgetState();
}

class TextFormStyledWidgetState extends State<TextFormStyledWidget> {
  bool _isPasswordVisible = false;
  @override
  void initState() {
    _isPasswordVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: width * 0.9,
              decoration: BoxDecoration(
                //border: OutlineInputBorder(),
                border: Border.all(
                  color: const Color(0xffADB5BD), // Color of the border
                  width: 1, // Width of the border
                ),
                borderRadius: const BorderRadius.all(
                    Radius.circular(40)), // Optional: Add rounded corners

                color: Colors.white,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                child: TextFormField(
                  validator: ((value) => widget.validator(value)),
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  onTap: () => widget.action,
                  obscureText: _isPasswordVisible,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) {
                    //print('cdsc');
                    widget.onChanged!(value);
                  },
                  decoration: InputDecoration(
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              color: const Color(0xffADB5BD),
                              icon: Icon(
                                !_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            )
                          : null,
                      isDense: true,
                      enabledBorder: null,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        widget.icon,
                        color: const Color(0xffADB5BD),
                      ),
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(color: Color(0xffADB5BD))),
                ),
              ),
            ),
            if (widget.errorText != null && widget.errorText != '')
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  widget.errorText!,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              )
          ],
        ),
      ],
    );
  }
}
