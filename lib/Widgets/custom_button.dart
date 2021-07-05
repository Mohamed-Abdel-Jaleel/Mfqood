import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.padding,
    required this.radius,
    required this.backgroundColor,
    required this.isLoading})
      : super(key: key);
  final String text ;
  final double height;
  final double padding;
  final double radius;
  final Color backgroundColor;
  final bool isLoading;

  final VoidCallback onPressed ;

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ;

    return Container(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Visibility(
            visible: _isLoading ? false : true ,
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, 20, padding, 0),
              child: SizedBox(
                height: height,
                child: ElevatedButton(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: ConstStyle.ButtonTextStyle,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                        // side: BorderSide(
                        //   color: Color(0xFF7B1FA2),
                        // ),
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading ,
            child: Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
