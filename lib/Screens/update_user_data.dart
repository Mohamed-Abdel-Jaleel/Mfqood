import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/simple_custom_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  File? _image;
  String _imgPath = "images/icons/open_camera.png";
  bool _isLoading = false;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Future getCameraImage(context) async {
    final _picker = ImagePicker();

    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      // imageQuality: 100,
    );
    _image = File(pickedFile!.path);
    uploadUserImage(_image!.path);
  }

  uploadUserImage(imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var url = Uri.parse(
        "https://mafkoud-api.herokuapp.com/api/user/me/profile-image");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final file = await http.MultipartFile.fromPath(
      'image',
      imagePath,
      contentType: new MediaType('image', 'jpeg'),
    );

    var request = new http.MultipartRequest("PATCH", url);

    request.headers.addAll(headers);
    request.files.add(file);

    request.send().then((response) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          _imgPath = imagePath;
        });
      } else {
        print("Failed");
      }
    });
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'images/found_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            _image != null
                ? Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.contain,
              ),
            )
                : IconButton(
              onPressed: () => getCameraImage(context),
              icon: Image.asset(
                'images/icons/open_camera.png',
              ),
            ),
            TextButton(
              onPressed: () => getCameraImage(context),
              child: Text(
                'Take Photo',
                style: ConstStyle.semiBoldedColoredText,
              ),
            ),
            SimpleInput(
              controller: locationController,
              hint: "Enter CHild Name ...",
            ),

            SimpleInput(
              controller: ageController,
              hint: "Enter Child Age ...",
            ),
            SimpleInput(
              controller: genderController,
              hint: "Enter Child gender ...",
            ),

            Spacer(),
/*
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name : ',
                  style: ConstStyle.semiBoldedColoredText,
                ),
                Text(
                  'Mohamed Ateya ',
                  style: ConstStyle.DefaultText,
                ),
              ],
            ),
*/
            CustomButton(
              isLoading: _isLoading,
              text: 'Add',
              onPressed: () => getCameraImage(context),
              height: 65,
              padding: 36,
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }

}
