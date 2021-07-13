import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfqood/Screens/login_page.dart';
import 'package:mfqood/Screens/phone_code_auth.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/custom_input.dart';
import 'package:mfqood/Widgets/custom_password_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'home_page.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _registerFormLoading = false;

  final TextEditingController _nameController= TextEditingController();

  final TextEditingController _emailController= TextEditingController();

  final TextEditingController _phoneController= TextEditingController();

  final TextEditingController _passwordController= TextEditingController();
  _validate(context){
    FocusScope.of(context).unfocus();
    if(_nameController.text.isEmpty
        || _emailController.text.isEmpty
        || _phoneController.text.isEmpty || _passwordController.text.isEmpty
    ){
      Toast.show("All Fields can\'t be Empty\n"
          "- enter all required fields",
        context,
        duration: Toast.LENGTH_LONG,
        gravity:  Toast.BOTTOM ,);
    }else if(_passwordController.text.length<8){
      Toast.show("Password must be 8 letters at least \n"
          "# Minimum 1 Upper case\n"
          "# Minimum 1 lowercase\n"
          "# Minimum 1 Numeric Number\n"
          "# Minimum 1 Special Character",
        context,
        duration: Toast.LENGTH_LONG,
        gravity:  Toast.BOTTOM ,);
    }else{
      _signUp(context);
    }
  }

  _signUp(context) async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registerFormLoading = true;
    });
    String email = _emailController.text.trim();
    String pass  = _passwordController.text.trim();
    String phone = _phoneController.text.trim();
    String name  = _nameController.text.trim();

    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/auth/register");

    Map body = {
      "name": name,
      "email": email,
      "password": pass,
      "phone": "2$phone",
      "role": "user"
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.post(url , body: body );
    var jsonResponse ;

    if(res.statusCode == 201 ){
      jsonResponse = jsonDecode(res.body);
      var token = jsonResponse['tokens']['access']['token'];
      var id = jsonResponse['user']['_id'];

      prefs.setString("token", token);
      prefs.setString("id", id);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return PhoneCodeAuth(phone: phone,);
            },
          ), (route) => false
      );
    }
    else {
      setState(() {
        _registerFormLoading = false;
      });
      // _emailController.clear();
      // _passwordController.clear();
      // _nameController.clear();
      // _phoneController.clear();
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
                'Sign up',
                style: ConstStyle.BoldFirstHeading,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
                  child: Text(
                    'I have an account ?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text(
                    'Login Now.',
                    style: ConstStyle.ColoredButtonTextStyle,
                  ),
                ),
              ],
            ),

            //Full name
            CustomInput(
              controller: _nameController,
              hint: 'Full Name',
              prefixIcon: Icons.person,
              onChanged: (val){
              },
              onSumbitted: (val){
              },
            ),
            //Email Address
            CustomInput(
              controller: _emailController,
              hint: 'Email Address',
              prefixIcon: Icons.email_outlined,
              onChanged: (val){
              },
              onSumbitted: (val){
              },
            ),
            //phone
            CustomInput(
              controller: _phoneController,
              hint: 'Phone',
              prefixIcon: Icons.phone,
              onChanged: (val){
              },
              onSumbitted: (val){
              },
            ),
            //password
            CustomPasswordInput(
              onChanged: (val){},
              onSumbitted: (val)=>_validate(context),
              prefixIcon: Icons.lock,
              controller: _passwordController,
              hint: 'Password',
            ),

            CustomButton(
              isLoading: _registerFormLoading ,
              backgroundColor: Theme.of(context).buttonColor,
              radius: 25,
              padding: 36,
              height: 65,
              onPressed: (){
                _validate(context);
              },
              text: 'SIGN UP',
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



