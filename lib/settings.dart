import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/customer_size_list.dart';
import 'package:tailor_app/utilities/colors.dart';
import 'package:tailor_app/utilities/shared_widgets.dart';

import 'login.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingState();
}

class SettingState extends State<Setting> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _showLoading = false;
  final _userEmailController = TextEditingController();
  late String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: ColorConstants.bottomBarColor,
        ),
        body: Card(
            margin: EdgeInsets.all(15),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Text("Logout"),
                      IconButton(
                        onPressed: () {
                          showAlertDialog(
                              message: "you want to logout ?",
                              context: context,
                              onNoPress: () {
                                Navigator.pop(context);
                              },
                              onYesPress: () async {
                                await FirebaseAuth.instance.signOut();
                                // checkLoginState();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Login()),
                                    ModalRoute.withName('/'));
                              });
                        },
                        icon: Icon(Icons.power_settings_new),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                child: Row(
                  children: [
                    Text("Check Measurement Detail"),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter state) {
                                return SingleChildScrollView(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(height: 15),
                                            buildPngImage(
                                                "fashiondesigner", 45, 45),
                                            SizedBox(height: 15),
                                            checkCustomSize(context),
                                            SizedBox(height: 15),
                                            checkMeasurementBtn(state),
                                          ],
                                        )));
                              });
                            });
                      },
                      icon: Icon(Icons.format_size),
                    ),
                  ],
                ),
              )
            ])));
  }

  Widget checkCustomSize(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
          // decoration: bgDecoration(),
          child: Column(children: [
            Text(
              "Check Measurement",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                hintText: "Enter user email",
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                fillColor: Colors.teal,
                // counter: Offstage(),
              ),
              onChanged: (value) {
                // this.username = value;
              },
              maxLines: 1,
              controller: _userEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter user email';
                } else {
                  setState(() {
                    userEmail = value;
                  });
                }
                return null;
              },
            ),
            SizedBox(height: 10),
          ])),
    );
  }

  Widget checkMeasurementBtn(StateSetter state) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: ColorConstants.bottomBarColor),
        child: Text('Check customer measurement details',
            style: TextStyle(color: ColorConstants.secondary)),
        onPressed: () {
          if (_key.currentState!.validate()) {
            state(
              () {
                _userEmailController.clear();
                _showLoading = true;
              },
            );
            //add data to users borrow record
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSizeList(userEmail: userEmail),
              ),
            );
          }
        });
  }
}
