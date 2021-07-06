import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput({Key? key, required this.controller, required this.hint}) : super(key: key);

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.fromLTRB(24, 4, 24, 4),
      child:Card(
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20),
        ),
        color:Colors.grey.shade100,
        child: Container(
          padding:EdgeInsets.only(left:12),
          child: TextFormField(
            controller: controller,
            decoration:InputDecoration(
              hintText:hint,
              border:InputBorder.none,
              fillColor:Colors.white,
            ),
          ),
        ),
      ),
    );

  }
}
