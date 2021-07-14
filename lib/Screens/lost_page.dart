import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';
import 'package:mfqood/Widgets/simple_custom_input.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'home_page.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:toast/toast.dart';

class LostPage extends StatefulWidget {
  const LostPage({Key? key}) : super(key: key);

  @override
  _LostPageState createState() => _LostPageState();
}

class _LostPageState extends State<LostPage> {
  File? _image;
  bool _isLoading = false;
  String genderSelected = "male";
  String? lostTime;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  Future<void> _selectTime(BuildContext context) async {

    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    int? h;
    if (pickedTime!.period == DayPeriod.pm) {
      if (pickedTime.hour > 12) {
        h = pickedTime.hour - 12;
      } else {
        h = pickedTime.hour;
      }
      lostTime = "$h:${pickedTime.minute} PM";
    } else {
      if (pickedTime.hour == 0) {
        h = pickedTime.hour + 12;
      } else {
        h = pickedTime.hour;
      }
      lostTime = "$h:${pickedTime.minute} AM";
    }
    setState(() {
      lostTime;
    });
  }

  Future getCameraImage(context) async {
    final _picker = ImagePicker();

    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      // imageQuality: 100,
    );
    _image = File(pickedFile!.path);

    final File imageFile = _image!;
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

    final List<Face> faces = await faceDetector.processImage(visionImage);
    int x = faces[0].boundingBox.left.toInt();
    int x_2 = faces[0].boundingBox.right.toInt();

    int y = faces[0].boundingBox.top.toInt();
    int y_2 = faces[0].boundingBox.bottom.toInt();
    int width = x_2 - x;
    int height = y_2 - y;

    File croppedFile =
        await FlutterNativeImage.cropImage(_image!.path, x, y, width, height);

    File resizedImage = await FlutterNativeImage.compressImage(
      croppedFile.path,
      // quality: 50,
      targetWidth: 224,
      targetHeight: 224,
    );

    setState(() {
      _image = resizedImage;
    });
  }

  _addLostChild(context) async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse("https://mafkoud-api.herokuapp.com/api/child/lost");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final file = await http.MultipartFile.fromPath(
      'image',
      _image!.path,
      contentType: new MediaType('image', 'jpg'),
    );

    var request = new http.MultipartRequest("POST", url);

    request.headers.addAll(headers);

    request.fields['age'] = ageController.text.trim();
    request.fields['gender'] = genderSelected;
    request.fields['name'] = nameController.text.trim();
    request.fields['status'] = 'lost';
    request.fields['lostDate'] = lostTime!;

    request.files.add(file);

    // content type for multi part file
    // final mimeTypeData = lookupMimeType(_image!.path, headerBytes: [0xFF, 0xD8])!.split('/');
    // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])

    request.send().then((response) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ), (route) => false);
      } else {
        print(response.toString());
        print(response.statusCode);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  _validate(context) {
    FocusScope.of(context).unfocus();
    if (ageController.text.isEmpty ||
        nameController.text.isEmpty ||
        _image!.path.isEmpty) {
      Toast.show(
        "All Fields can\'t be Empty\n"
        "- enter all required fields",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    } else {
      _addLostChild(context);
    }
  }

  int selectedRadio = 1;

  setSelected(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void initState() {

    TimeOfDay initialTime = TimeOfDay.now();
    lostTime = initialTime.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      //new line
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CusomActionBar(
              openDrawer: () {},
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
            _image != null
                ? Container(
                    width: 140,
                    height: 140,
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
                      'images/icons/choose_img.png',
                    ),
                  ),
            TextButton(
              onPressed: () => getCameraImage(context),
              child: Text(
                'Add Photo',
                style: ConstStyle.semiBoldedColoredText,
              ),
            ),
            SimpleInput(
              controller: nameController,
              hint: "Enter CHild Name ...",
            ),
            SimpleInput(
              controller: ageController,
              hint: "Enter Child Age ...",
            ),
            // SimpleInput(
            //   controller: genderController,
            //   hint: "Enter Child gender ...",
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 8, 36, 0),
              child: RadioListTile(
                value: 1,
                groupValue: selectedRadio,
                onChanged: (val) {
                  genderSelected = "male";
                  val as int;
                  setSelected(val);
                },
                title: Text("Male"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
              child: RadioListTile(
                value: 2,
                groupValue: selectedRadio,
                onChanged: (val) {
                  genderSelected = "female";
                  val as int;
                  setSelected(val);
                },
                title: Text("Female"),
              ),
            ),
            CustomButton(
                text: "Pick Lost Time $lostTime",
                onPressed: () => _selectTime(context),
                height: 65,
                padding: 36,
                radius: 10,
                backgroundColor: Colors.grey,
                isLoading: false),
            Spacer(),
            CustomButton(
              isLoading: _isLoading,
              text: 'Add',
              onPressed: () => _validate(context),
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
