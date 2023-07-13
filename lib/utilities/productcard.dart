import 'package:flutter/material.dart';
import 'package:tailor_app/utilities/avtar_image.dart';

import 'colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard({Key? key , @required this.item}) : super(key: key);
  final item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 255,
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            child: AvatarImage(item["photo"],
              width: 110, height: 110, isSVG: false, borderColor: ColorConstants.accentColor,
            ),
            // ),
          ),
          SizedBox(height: 15,),
          Text(item["clothName"],
              maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: ColorConstants.primary ,fontWeight: FontWeight.w600)
          ),
          SizedBox(height: 8,),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(text: '£' " " + item["sellingPrice"], style: TextStyle(fontSize: 16, color: ColorConstants.primary ,fontWeight: FontWeight.w500)),
                    TextSpan(text: "   "),
                    TextSpan(text: '£' " " +item["originalPrice"],
                        style: TextStyle(color: Colors.grey, fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500)
                    ),
                  ]
              )
          )
        ],
      ),
    );
  }
}