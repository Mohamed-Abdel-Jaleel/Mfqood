import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/simple_custom_input.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class PhoneCodeAuth extends StatelessWidget {
  PhoneCodeAuth({Key? key}) : super(key: key);

  TextEditingController _controller = TextEditingController();

  verifyWithCode(context) async {

    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/auth/verify/phone");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map body = {
      "code": _controller.text,
    };


    var res = await http.post(url , body: jsonEncode(body) ,headers: headers );
    var jsonResponse ;


    print(res.body);
    if(res.statusCode == 200 ){
      // jsonResponse = jsonDecode(res.body);

      Toast.show("Success",
        context,
        duration: Toast.LENGTH_LONG,
        gravity:  Toast.BOTTOM ,);
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return HomePage();
      //       },
      //     ), (route) => false
      // );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      resizeToAvoidBottomInset: false, //new line
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CusomActionBar(
              openDrawer: (){},
              hasBackground: false,
              hasIconButtons: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'images/lost_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: SizedBox(
                height: 200,
                child: Image.asset(
                  'images/phone.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

             SizedBox(height: 42,),
             Text(
                "please type the verification code sent to +20123456789",
                style: ConstStyle.semiBoldedText,
                textAlign: TextAlign.center,
              ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(20),
                ),
                color:Colors.grey.shade100,
                child: Container(
                  width: 240,
                  child: TextFormField(
                    scrollPadding: EdgeInsets.only(bottom:100),
                    controller: _controller,
                    decoration:InputDecoration(
                      hintText:"",

                      border:InputBorder.none,
                      fillColor:Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color:Color(0xFF81248A),
                      height: 1.2,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(
              isLoading: false,
              text: 'Add',
              onPressed: ()=> verifyWithCode(context) ,
              height: 65,
              padding: 65,
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
                  child: Text(
                    'Didn\'t get the code ?',
                    style: ConstStyle.DefaultText,
                  ),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text(
                    'Resend.',
                    style: ConstStyle.ColoredButtonTextStyle,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
