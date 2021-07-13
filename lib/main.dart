// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mfqood/Screens/home_page.dart';
import 'package:mfqood/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_splash/custom_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF81248A), // status bar color
    statusBarBrightness: Brightness.light, //status bar brigtness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSplash(
      imagePath: 'images/textLogo.png',
      backGroundColor: Color(0xFF81248A),
      animationEffect: 'zoom-out',
      logoSize: 250,
      home: MyApp(token: token, ),
      duration: 2000,
      type: CustomSplashType.StaticDuration,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String token;

  const MyApp({Key key,  this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mafqood',
      theme: ThemeData(
        //primarySwatch: Colors.purple,
        shadowColor: Color(0xFFDE0882),
        primaryColor: Color(0xFF81248A),
        accentColor: Color(0xFFDE0882),
        buttonColor: Color(0xFFDE0882),
        // add more colors ...
      ),
      home: token != null ? HomePage() : LoginPage(),
    );
  }
}
