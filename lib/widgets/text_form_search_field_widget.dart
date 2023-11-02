import 'package:flutter/material.dart';

class TextFormSearchStyledWidget extends StatefulWidget {
  const TextFormSearchStyledWidget(
      {Key? key,
      required this.label,
      required this.placeholder,
      required this.icon,
      this.controller,
      this.keyboardType,
      this.action,
      this.isPassword = false,
      required this.validator,
      this.decoration,
      this.obscureText})
      : super(key: key);
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

  @override
  _TextFormSearchStyled createState() => _TextFormSearchStyled();
}

class _TextFormSearchStyled extends State<TextFormSearchStyledWidget> {
  bool _isPasswordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    _isPasswordVisible = widget.isPassword;
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8),
            width: width * 0.9,
            decoration: BoxDecoration(
              //border: OutlineInputBorder(),
              border: Border.all(
                color: Color(0xffECECEC), // Color of the border
                width: 1, // Width of the border
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)), // Optional: Add rounded corners

              color: Colors.white,
            ),
            child: Center(
              child: TextFormField(
                validator: ((value) => widget.validator(value)),
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                onTap: () => widget.action,
                obscureText: _isPasswordVisible ?? false,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            alignment: Alignment.center,
                            color: Colors.grey,
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
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(
                      widget.icon,
                      size: 24,
                      color: Color(0xff112A59),
                    ),
                    fillColor: const Color.fromARGB(255, 0, 0, 0),
                    hintText: widget.placeholder ?? ' ',
                    hintStyle:
                        TextStyle(color: Color(0xff879EA4), fontSize: 18)),
              ),
            ))
      ],
    );
  }
}
