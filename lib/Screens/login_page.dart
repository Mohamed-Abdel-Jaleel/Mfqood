import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfqood/Screens/home_page.dart';
import 'package:mfqood/Screens/signup_page.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/custom_input.dart';
import 'package:mfqood/Widgets/custom_password_input.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loginFormLoading = false;
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();

   _login(context) async {
     FocusScope.of(context).unfocus();

     setState(() {
       _loginFormLoading = true;
     });



    //var url = Uri.parse("http://localhost:8000/api/auth/login");
    //var url = Uri.parse("http://10.0.2.2:8000/api/auth/login");
    //var url = Uri.parse("http://192.168.1.9:8000/api/auth/login");

    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/auth/login");

    String email = emailController.text.trim();
    String pass  = passwordController.text.trim();


    Map body = {
      "email": email,
      "password": pass,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.post(url , body: body);
    var jsonResponse ;

    if(res.statusCode == 200 ){

      jsonResponse = jsonDecode(res.body);
      var token = jsonResponse['tokens']['access']['token'];
      prefs.setString("token", token);
      
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ), (route) => false
      );
    }else {
      setState(() {
        _loginFormLoading = false;
      });
      emailController.clear();
      passwordController.clear();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CusomActionBar(
              openDrawer: (){},
              hasBackground: true,
              hasIconButtons: false,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(36, 12, 0, 8),
              child: Text(
                'Login',
                style: ConstStyle.BoldFirstHeading,
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
                  child: Text(
                    'Don\'t have an account ?',
                    style: ConstStyle.DefaultText,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SignupPage();
                      },
                    ));
                  },
                  child: Text(
                    'Create new account.',
                    style: ConstStyle.ColoredButtonTextStyle,
                  ),
                ),
              ],
            ),
            //email
            CustomInput(
              controller: emailController,
              hint: 'Email Address',
              prefixIcon: Icons.email_outlined,
              onChanged: (val){
              },
              onSumbitted: (val){
              },
            ),
            //password
            CustomPasswordInput(
              onChanged: (val){},
              onSumbitted: (val){},
              prefixIcon: Icons.lock,
              controller: passwordController,
              hint: 'password',
            ),

            CustomButton(
              backgroundColor: Theme.of(context).buttonColor,
              radius: 25,
              padding: 36,
              height: 65,
              isLoading: _loginFormLoading,
              onPressed: (){
                _login(context);
              },
              text: 'LOGIN',
            ),

            Align(
              alignment: Alignment(1, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 36, 0),
                child: TextButton(
                  child: Text(
                    'Forget Password ?',
                    style: ConstStyle.ColoredButtonTextStyle,
                  ),
                  onPressed: (){print('Forget Password ?');},

                ),
              ),
            ),

            Spacer(),

            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'images/bottomAppBackground.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Image.asset(
                  'images/terms.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


