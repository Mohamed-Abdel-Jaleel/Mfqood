import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfqood/Models/child.dart';
import 'package:mfqood/Screens/found_page.dart';
import 'package:mfqood/Screens/login_page.dart';
import 'package:mfqood/Screens/lost_page.dart';
import 'package:mfqood/Widgets/child_widget.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Child> childs = [];

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ));
  }

  Future<List<Child>> getChildData() async {
    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/child");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    List<Child> data = [];

    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);
      for (var child in jsonResponse["childs"]) {
        data.add(Child.fromJson(child));
      }
      // for (Child c in data) {
      //   print(c.status);
      //   print(c.image);
      // }
    }
    return data;
  }

  @override
  void initState() {
    getChildData().then((value) {
      setState(() {
        childs.addAll(value);
      });
    });
    super.initState();
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
                hasBackground: true,
                hasIconButtons: true,
              ),
              CustomButton(
                isLoading: false,
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                text: 'I lost someone',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context){
                            return LostPage();
                          }
                      )
                  );
                },
                height: 80,
                padding: 36,
              ),
              CustomButton(
                isLoading: false,
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                text: 'I Found someone',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context){
                            return FoundPage();
                          }
                      )
                  );
                },
                height: 80,
                padding: 36,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(36, 20, 36, 10),
                child: Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey,
                ),
              ),

              Expanded(

                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ...childs.map((e) {
                      return ChildCard(
                        image: e.image,
                        name: e.location,
                        age: e.age,
                        status: e.status,
                      );
                    }).toList(),
                  ],
                ),
              ),


            ],
        ),
      ),
    );
  }
}
