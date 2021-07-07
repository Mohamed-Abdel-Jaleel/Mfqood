import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mfqood/Screens/home_page.dart';
import 'package:mfqood/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF81248A), // status bar color
    statusBarBrightness: Brightness.light, //status bar brigtness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
    // systemNavigationBarColor: Colors.white, // navigation bar color
    // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, required this.token}) : super(key: key);

  // This widget is the root of your application.
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
