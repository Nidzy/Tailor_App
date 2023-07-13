import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:tailor_app/utilities/colors.dart';

class AddUserSize extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddUserSizeState();
}

class AddUserSizeState extends State<AddUserSize> {
  GlobalKey<FormState> _key = new GlobalKey();
  final _customerNameController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _chestSizeController = TextEditingController();
  final _waistSizeController = TextEditingController();
  final _seat = TextEditingController();
  final _bicep = TextEditingController();
  final _length = TextEditingController();
  bool _validate = false;
  late String customerName,
      customerEmail,
      chestSize,
      waisetSize,
      seat,
      bicep,
      length;
  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer measurement details"),
        backgroundColor: ColorConstants.bottomBarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: 10),
              addMeasurementForm(),
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

  Widget addMeasurementForm() {
    return Form(
      key: _key,
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        // decoration: bgDecoration(),
        child: Column(children: [
        TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Customer Name',
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
            return 'Please enter customer name';
          } else {
            setState(() {
              customerName = value;
            });
          }
          return null;
        },
        maxLines: 1,
        controller: _customerNameController,
      ),
      SizedBox(height: 10),
      TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Customer Email',
          /* labelStyle: TextStyle(
                    color: ColorConstants.primaryColor,
                  ),*/
          suffixIcon: Icon(
            Icons.email_sharp,
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
            return 'Please enter customer email';
          } else {
            setState(() {
              customerEmail = value;
            });
          }
          return null;
        },
        maxLines: 1,
        controller: _customerEmailController,
      ),
      SizedBox(height: 10),
      TextFormField(
        keyboardType: TextInputType.number,
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Chest Size',
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
        controller: _chestSizeController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter chest size';
          } else {
            setState(() {
              chestSize = value;
            });
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Waist size',
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
        controller: _waistSizeController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter waist size';
          } else {
            setState(() {
              waisetSize = value;
            });
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Seat',
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
        controller: _seat,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter seat size';
          } else {
            setState(() {
              seat = value;
            });
          }
          return null;
        },),
      SizedBox(height: 10),

      TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // icon: Icon(Icons.email),
          //border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
          labelText: 'Bicep',
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
        controller: _bicep,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter bicep size';
          } else {
            setState(() {
              bicep = value;
            });
          }
          return null;
        },
      ),
    SizedBox(height: 10),
    SizedBox(height: 10),
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
            await addSizeData(
              customerName,
              customerEmail,
              waisetSize,
              chestSize,
              seat,
              bicep,
            );
          }
        },
        child: Text(
          'Add Size Data',
          style: TextStyle(color: ColorConstants.secondary),
        ));
  }

  Future<void> addSizeData(String customerName, String customerEmail,
      String chest, String waist, String seat, String bicep) async {
    try {
      FirebaseFirestore.instance
          .collection('customerSize')
          .doc(customerEmail)
          .collection('customerSizeData')
          .add({
        "customerName": customerName,
        "customerEmail": customerEmail,
        "chest": chest,
        "waist": waist,
        "seat": seat,
        "bicep": bicep,
      });
      setState(() {
        _showLoading = false;
        _customerNameController.clear();
        _customerEmailController.clear();
        _chestSizeController.clear();
        _waistSizeController.clear();
        _bicep.clear();
        _seat.clear();
        _bicep.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ColorConstants.bottomBarColor,
          content: Text('Customers Size successfully added',
              style: TextStyle(color: ColorConstants.secondary))));
      Navigator.of(context).pop();
    } on firebase_core.FirebaseException catch (e) {
      print("Error ${e.message}");
    }
  }
}
