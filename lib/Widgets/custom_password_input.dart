import 'package:flutter/material.dart';

import 'const_style.dart';

class CustomPasswordInput extends StatefulWidget {
  const CustomPasswordInput({Key? key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    required this.onChanged,
    required this.onSumbitted,

  }) : super(key: key);


  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final Function(String) onChanged;
  final Function(String) onSumbitted;


  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  late bool passwordVisibility;
  @override
  void initState() {
    passwordVisibility = false;
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(36, 8, 36, 0),
      child: TextField(
        obscureText: !passwordVisibility,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle:ConstStyle.HintTextField,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF9E9E9E),
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF848383),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: InkWell(
            onTap: () => setState(
                  () => passwordVisibility = !passwordVisibility,
            ),
            child: Icon(
              passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Color(0xFF757575),
              size: 22,
            ),
          ),
        ),

        style: ConstStyle.TextField,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSumbitted,

      ),

    );

  }
}
