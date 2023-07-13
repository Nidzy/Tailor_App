import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_app/utilities/colors.dart';
import 'package:tailor_app/utilities/shared_widgets.dart';

class RequestCustomization extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RequestCustomizationState();
}

class RequestCustomizationState extends State<RequestCustomization> {
  GlobalKey<FormState> _key = new GlobalKey();
  final _clothNameController = TextEditingController();
  final _clothColorController = TextEditingController();
  final _clothNoteController = TextEditingController();
  bool _validate = false;
  double clothQuantity = 0;

  late String clothName, clothColor , requestNote;
  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile _imageFile = XFile("");
  dynamic _pickImageError;
  late String downloadURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Customisation"),
        backgroundColor: ColorConstants.bottomBarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: 10),
              requestClothForm(),
              _showLoading
                  ? Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
                  : button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestClothForm() {
    return Form(
      key: _key,
      child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
          // decoration: bgDecoration(),
          child: Column(children: [
            Text("Click here to upload photo"),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: _imageFile.path.isEmpty
                  ? buildPngImage("camera", 60, 60)
                  : Image.file(File(_imageFile.path), height: 70),
              /*,*/
              onTap: () {
                showOptionsDialog(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                // icon: Icon(Icons.email),
                //border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                labelText: 'Cloth item Name',
                /* labelStyle: TextStyle(
                    color: ColorConstants.primaryColor,
                  ),*/
                suffixIcon: Icon(
                  Icons.book,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(width: 1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    )),
              ),
              onChanged: (value) {
                // this.username = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter cloth name';
                } else {
                  setState(() {
                    clothName = value;
                  });
                }
                return null;
              },
              maxLines: 1,
              controller: _clothNameController,
            ),
            SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                // icon: Icon(Icons.email),
                //border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                labelText: 'cloth color',
                /* labelStyle: TextStyle(
                    color: ColorConstants.primaryColor,
                  ),*/
                suffixIcon: Icon(
                  Icons.edit_outlined,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(width: 1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    )),
              ),
              onChanged: (value) {
                // this.username = value;
              },
              maxLines: 1,
              controller: _clothColorController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter cloth color';
                } else {
                  setState(() {
                    clothColor = value;
                  });
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                // icon: Icon(Icons.email),
                //border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                labelText: 'request note',
                /* labelStyle: TextStyle(
                    color: ColorConstants.primaryColor,
                  ),*/
                suffixIcon: Icon(
                  Icons.edit_outlined,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(width: 1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.primaryColor, width: 1),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    )),
              ),
              onChanged: (value) {
                // this.username = value;
              },
              maxLines: 1,
              controller: _clothNoteController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter request note';
                } else {
                  setState(() {
                    requestNote = value;
                  });
                }
                return null;
              },
            ),
          ])),
    );
  }

  Widget button() {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: ColorConstants.bottomBarColor),
        onPressed: () async {
          if (_key.currentState!.validate()) {
            setState(() {
              _showLoading = true;
            });

            await uploadFileAndAddClothRequestData(_imageFile.path);
          }
        },
        child: Text(
          'Submit Request for customisation',
          style: TextStyle(color: ColorConstants.secondary),
        ));
  }

  //function called when tapped on camera image
  void _onImageTap(ImageSource source, {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: null,
        maxHeight: null,
        imageQuality: 60,
      );
      setState(() {
        _imageFile = pickedFile!;
        print(_imageFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  //alert dialog for choosing camera/ gallery option
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Photo"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Camera"),
                    ),
                    onTap: () {
                      _onImageTap(ImageSource.camera, context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Gallery"),
                    ),
                    onTap: () {
                      _onImageTap(ImageSource.gallery, context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadFileAndAddClothRequestData(String filePath) async {
    File file = File(filePath);
    try {
      String refImage = "images/requestedCloths/${DateTime.now()}.jpg";

      var result = await firebase_storage.FirebaseStorage.instance
          .ref(refImage)
          .putFile(file);
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(refImage)
          .getDownloadURL();
      var userId = FirebaseAuth.instance.currentUser?.uid;
      var userEmail = FirebaseAuth.instance.currentUser?.email;
      print(userId);
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (downloadURL.isEmpty) {
        downloadURL =
        "https://s26162.pcdn.co/wp-content/uploads/2019/12/46301955-668x1024.jpg";
      }

      FirebaseFirestore.instance
          .collection('clothRequest')
          .doc(userEmail)
          .collection('requestedClothList')
          .add({
        "clothName": clothName,
        "photo": downloadURL,
        "clothColor": clothColor,
        "requestNote":requestNote,
        "userEmail": userEmail,
      });
      print("downloadURL ${downloadURL}");
      setState(() {
        _showLoading = false;
        _clothNameController.clear();
        _clothColorController.clear();
        _clothNoteController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ColorConstants.bottomBarColor,
          content: Text('Cloth request sent successfully',
              style: TextStyle(color: ColorConstants.secondary))));
      Navigator.of(context).pop();
    } on firebase_core.FirebaseException catch (e) {
      print("Error ${e.message}");
    }
  }
}
