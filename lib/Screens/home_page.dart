import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfqood/Models/child.dart';
import 'package:mfqood/Screens/found_page.dart';
import 'package:mfqood/Screens/login_page.dart';
import 'package:mfqood/Screens/lost_page.dart';
import 'package:mfqood/Screens/phone_code_auth.dart';
import 'package:mfqood/Screens/update_user_data.dart';
import 'package:mfqood/Widgets/child_widget.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Child> childs = [];
  String? userEmail, userPhone, userName, userImage, id, token;

  @override
  void initState() {
    getUserData();
    getChildData().then((value) {
      setState(() {
        childs.addAll(value);
      });
    });
    super.initState();
  }

  Future logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ), (route) => false);
  }

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/user/$id");

    var res = await http.get(url);
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);

      setState(() {
        userEmail = jsonResponse["user"]["email"];
        userPhone = jsonResponse["user"]["phone"];
        userName = jsonResponse["user"]["name"];
        userImage = jsonResponse["user"]["profileImage"];
      });
    }
  }

  Future<List<Child>> getChildData() async {
    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/child");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");

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
    }
    return data;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(context),
        resizeToAvoidBottomInset: false,
        //new line
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CusomActionBar(
                  openDrawer: () {
                    Scaffold.of(context).openDrawer();
                  },
                  hasBackground: true,
                  hasIconButtons: true,
                ),
                CustomButton(
                  isLoading: false,
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColor,
                  text: 'I lost someone',
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LostPage();
                    }));
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FoundPage();
                    }));
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
                          name: e.name,
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
        ));
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 24,
              ),
              DrawerHeader(
                child: Container(
                  width: 120,
                  height: 120,
                  color: Color(0xFF9E9E9E),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                  ),
                  child: userImage == null || userImage == ""
                      ? IconButton(
                          onPressed: () => openEditUser(context),
                          icon: Image.asset(
                            "images/icons/open_camera.png",
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      : Image.network(
                          userImage!,
                        ),
                ),
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () => openEditUser(context),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                title: Text(
                  userName == null ? "User Name" : userName!,
                  style: ConstStyle.semiBoldedText,
                ),
                // dense: true,
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () => openEditUser(context),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                title: Text(
                  userPhone == null ? "Phone Number" : userPhone!,
                  style: ConstStyle.semiBoldedText,
                ),
                // dense: true,
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () => openEditUser(context),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                title: Text(
                  userEmail == null ? "User Email" : userEmail!,
                  style: ConstStyle.semiBoldedText,
                ),
                // dense: true,
              ),
            ],
          ),
          Spacer(),
          CustomButton(
            isLoading: false,
            text: 'Logout',
            onPressed: logout,
            height: 65,
            padding: 36,
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  openEditUser(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateUser(
        image:userImage ,
        email: userEmail,
        name: userName,
        phone: userPhone,
      );
    }));
  }
}
