import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfqood/Models/child.dart';
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

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ));
  }

   getChildData() async {
    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/child");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");


    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonResponse ;

    if(res.statusCode==200){
      jsonResponse = jsonDecode(res.body);
      print(res.body);
      print("++++++++++++++++++");

      List<dynamic> childData = jsonResponse["childs"];

      for(var c in childData){
        // Child child = Child.fromJson(c);
        // childData.add(child);

        print("++++++++++++++++++");
        print(childData.length);
        print(c.toString());
      }

    }


  }

  @override
  Widget build(BuildContext context) {
    getChildData();
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
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              text: 'I lost someone',
              onPressed: () {
                //TODO
                //
                // Navigator.of(context).push(
                //     MaterialPageRoute(
                //         builder: (context){
                //           return LostPage();
                //         }
                //     )
                // );
              },
              height: 80,
              padding: 36,
            ),
            CustomButton(
              isLoading: false,
              radius: 20,
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              text: 'I Found someone',
              onPressed: () {
                //TODO
              },
              height: 80,
              padding: 36,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(36, 20, 36, 0),
              child: Container(
                height: 1,
                width: 200,
                color: Colors.grey,
              ),
            ),

            //////////////////
            ChildCard(
              image: "https://image.shutterstock.com/image-photo/cute-little-baby-girl-looking-260nw-327635408.jpg",
              name: "Mohamed Ateya",
              age: "22",
              status: "lost",
            ),

            FutureBuilder(
              future: getChildData(),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  );
                }else
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(snapshot.data.toString());
                    },

                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
