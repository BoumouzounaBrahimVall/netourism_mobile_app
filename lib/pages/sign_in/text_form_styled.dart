import 'package:flutter/material.dart';

class TextFormStyled extends StatefulWidget {
  const TextFormStyled(
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
  _TextFormStyledState createState() => _TextFormStyledState();
}

class _TextFormStyledState extends State<TextFormStyled> {
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
          height: 48,
          alignment: Alignment.center,
          width: width * 0.9,
          decoration: BoxDecoration(
            //border: OutlineInputBorder(),
            border: Border.all(
              color: Color(0xffADB5BD), // Color of the border
              width: 1, // Width of the border
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(40)), // Optional: Add rounded corners

            color: Colors.white,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 4),
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
                          color: Color(0xffADB5BD),
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
                    color: Color(0xffADB5BD),
                  ),
                  fillColor: const Color.fromARGB(255, 0, 0, 0),
                  hintText: widget.placeholder ?? ' ',
                  hintStyle: TextStyle(color: Color(0xffADB5BD))),
            ),
          ),
        )
      ],
    );
  }
}
