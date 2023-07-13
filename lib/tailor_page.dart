import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/utilities/tailor_item.dart';
import 'package:tailor_app/utilities/colors.dart';
import 'package:tailor_app/utilities/productcard.dart';

import 'data/item_data.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({ Key? key }) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  @override
  Widget build(BuildContext context) {
    return
      body();
  }

  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorConstants.bottomBarColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                indicatorColor: ColorConstants.bottomBarColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.primaryColor,
                ),
                labelPadding: EdgeInsets.only(top: 8, bottom: 8),
                unselectedLabelColor: ColorConstants.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Text( "Available Clothes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  Text( "Requested Clothes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  getAvailableItems(),
                  ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 15, right:15),
                      children: getNewItems()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getNewItems(){
    return
      List.generate(latestItems.length, (index) =>
          ArtItem(book: latestItems[index],)
      );
  }


  getAvailableItems() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("cloths")
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return  ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var clothItem = snapshot.data!.docs[index];
              print(clothItem["clothName"]);
              //double _width = 75, _height = 100;

              return Container(
                  padding: EdgeInsets.all(8),
                  child: ItemCard(item: clothItem));
            },
          );
        });
  }

}