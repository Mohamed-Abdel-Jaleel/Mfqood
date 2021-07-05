import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final Function(String) onChanged;
  final Function(String) onSumbitted;

  const CustomInput({Key? key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    required this.onChanged,
    required this.onSumbitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: EdgeInsets.fromLTRB(36, 8, 36, 0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
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
            prefixIcon: Icon(prefixIcon),
          ),

          style: ConstStyle.TextField,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,

          onChanged: onChanged,
          onSubmitted: onSumbitted,

        ),

    );
  }
}
