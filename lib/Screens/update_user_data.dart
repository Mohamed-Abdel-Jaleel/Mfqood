import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfqood/Screens/home_page.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/simple_custom_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';

class UpdateUser extends StatefulWidget {
  final String? name, phone, email, image;

  const UpdateUser(
      {Key? key,
      required this.name,
      required this.phone,
      required this.email,
      required this.image})
      : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  File? _image;
  String? _imgPath;

  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.name!;
    emailController.text = widget.email!;
    phoneController.text = widget.phone!;
    _imgPath = widget.image!;

    super.initState();
  }

  Future getCameraImage(context) async {
    final _picker = ImagePicker();
    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    _image = File(pickedFile!.path);
    //uploadUserImage(_image!.path);
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
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context){
          return HomePage();
        })
        , (route) => false);
      } else {
        setState(() {
          _isLoading=false;
        });

      }
    });
  }

  updateDetails(context){
    setState(() {
      _isLoading = true;
    });
    if(_image!=null){
      uploadUserImage(_image!.path);
    }else{
      Toast.show("Choose Image first",
          context,
          duration: Toast.LENGTH_LONG,
          gravity:  Toast.BOTTOM ,);

      setState(() {
        _isLoading=false;
      });
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
              hasIconButtons: true,
              hasBackground: false,
            ),
            SizedBox(
              height: 24,
            ),

            Container(
              width: 100,
              height: 100,
              color: Color(0xFFE5E4E4),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: _imgPath == null || _imgPath == ""
                  ? IconButton(
                      onPressed: () => getCameraImage(context),
                      icon: Image.asset(
                        'images/icons/open_camera.png',
                      ),
                    )
                  : Image.network(
                      _imgPath!,
                      fit: BoxFit.contain,
                    ),
            ),
            TextButton(
              onPressed: () => getCameraImage(context),
              child: Text(
                'Choose Photo',
                style: ConstStyle.semiBoldedColoredText,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SimpleInput(
              controller: nameController,
              hint: "Enter User Name ...",
            ),
            SimpleInput(
              controller: emailController,
              hint: "Enter User Email ...",
            ),
            SimpleInput(
              controller: phoneController,
              hint: "Enter User Phone ...",
            ),
            Spacer(),
            CustomButton(
              isLoading: _isLoading,
              text: 'Update',
              onPressed: () => updateDetails(context),
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
