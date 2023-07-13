import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart';


class ArtItem extends StatelessWidget {
  ArtItem({  Key? key, @required this.book }) : super(key: key);
  final book;

  @override
  Widget build(BuildContext context) {
    double _width = 80, _height = 110;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Stack(
                children: [
                  Card(child: Container(
                      width: _width, height: _height,
                      padding: EdgeInsets.all(8),
                      // child: buildPngImage(book["image"], 50, 50
                      child: Image(image: AssetImage(book["image"])) /*Image.file(
                      File(book["image"],),
                      fit: BoxFit.cover,
                    ),*/
                  ))
                ]
            ),
            SizedBox(width: 18,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book["title"], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                SizedBox(height: 12,),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: book["price"], style: TextStyle(fontSize: 16, color: ColorConstants.primary ,fontWeight: FontWeight.w500)),
                      TextSpan(text: "   "),
                      TextSpan(text: book["ori_price"],
                          style: TextStyle(color: Colors.grey, fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500)
                      ),
                    ]
                ))
              ],
            )
          ],
        )
    );
  }
}