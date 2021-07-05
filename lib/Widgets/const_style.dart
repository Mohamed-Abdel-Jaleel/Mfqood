import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstStyle{

  static const TextStyle ButtonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static const TextStyle ColoredButtonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    color: Color(0xFFDE0882),
    fontSize: 13,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );


  static const TextStyle BoldFirstHeading =TextStyle(
    fontFamily: 'Poppins',
    fontSize: 34,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle TextField = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.0,
    fontStyle: FontStyle.normal,
  );
  static const TextStyle HintTextField = TextStyle(
    fontFamily: 'Poppins',
  );
  static const TextStyle semiBoldedText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.0,
    fontStyle: FontStyle.normal,
  );
  static const TextStyle semiBoldedColoredText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color:Color(0xFF81248A),
    height: 1.0,
    fontStyle: FontStyle.normal,
  );
  static const TextStyle DefaultText = TextStyle(
    fontFamily: 'Poppins',


        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,

  );

  static const TextStyle greenHint = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.green,
  );

  static const TextStyle redHint = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.red,
  );


}