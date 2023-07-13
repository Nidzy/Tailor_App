import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:tailor_app/utilities/colors.dart';
import 'package:tailor_app/utilities/shared_widgets.dart';

class AddItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddItemState();
}

class AddItemState extends State<AddItem> {
  GlobalKey<FormState> _key = new GlobalKey();
  final _clothNameController = TextEditingController();
  final _clothTypeController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  bool _validate = false;
  double bookQuantity = 0;
  late String orignalPrice;
  late String sellingPrice;

  late String clothName, clothColor, quantity, UUID;
  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile _imageFile = XFile("");
  dynamic _pickImageError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cloth"),
        backgroundColor: ColorConstants.bottomBarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: 10),
              addBookForm(),
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

  Widget addBookForm() {
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
                labelText: 'Cloth Name',
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
                labelText: 'Cloth Type',
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
              controller: _clothTypeController,
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                // icon: Icon(Icons.email),
                //border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                labelText: 'Original Price',
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
              controller: _originalPriceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter original price';
                } else {
                  setState(() {
                    orignalPrice = value;
                  });
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                // icon: Icon(Icons.email),
                //border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                labelText: 'Selling Price',
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
              controller: _sellingPriceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter selling price';
                } else {
                  setState(() {
                    sellingPrice = value;
                  });
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text("Select quantity from below slider"),
            SizedBox(height: 10),
            Slider(
              value: bookQuantity,
              min: 0,
              max: 100,
              divisions: 10,
              onChangeStart: (double value) {
                print('Start value is ' + value.toString());
              },
              onChangeEnd: (double value) {
                print('Finish value is ' + value.toString());
              },
              onChanged: (double newValue) {
                setState(() {
                  bookQuantity = newValue;
                });
              },
              activeColor: ColorConstants.primaryColor,
              inactiveColor: ColorConstants.disabledColor,
              label: bookQuantity.toString(),
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

            await uploadFileAndAddClothData(_imageFile.path);

            /*await addBook(
                bookName,
                primaryAuthor,
                isbnNo,
                deweyClassificationNo,
                bookQuantity.toInt(),
                orignalPrice,
                sellingPrice);*/
          }
        },
        child: Text(
          'Add Cloth',
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

  /*
  *  upload cloth image and add cloth data to cloths collection on cloud firestore
  * */
  Future<void> uploadFileAndAddClothData(String filePath) async {
    File file = File(filePath);
    try {
      String refImage = "images/${DateTime.now()}.jpg";

      var result = await firebase_storage.FirebaseStorage.instance
          .ref(refImage)
          .putFile(file);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(refImage)
          .getDownloadURL();
      var userId = FirebaseAuth.instance.currentUser!.uid;
      print(userId);
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      FirebaseFirestore.instance.collection('cloths').add({
        "clothName": clothName,
        "photo": downloadURL,
        "clothColor": clothColor,
        "originalPrice": orignalPrice,
        "sellingPrice": sellingPrice,
        "quantity": bookQuantity.round(),
        "username": user['username'],
        "user_id": userId,
        "timestamp": FieldValue.serverTimestamp(),
        //"isBorrowed": false
      });
      print("downloadURL ${downloadURL}");
      setState(() {
        _showLoading = false;
        _clothNameController.clear();
        _clothTypeController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ColorConstants.bottomBarColor,
          content: Text('Successfully added',
              style: TextStyle(color: ColorConstants.secondary))));
      Navigator.of(context).pop();
    } on firebase_core.FirebaseException catch (e) {
      print("Error ${e.message}");
    }
  }
}
