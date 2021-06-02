import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'homeController.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  BuildContext? _context;
  HomeController controller= HomeController();


  initState(){
    super.initState();
    controller.setMainImage();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return mainLayout();
  }

  Widget mainLayout() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: [
          //FirstChild
          firstChild(),
          Spacer(),
          secondChild()
          //SecondChild
        ],
      ),
    );
  }

  Widget firstChild() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          clickableText("Choose Category", () {onSelectCategory();}),
          SizedBox(
            height: 10,
          ),
          Image.asset(controller.data[controller.mainImage]!),
          SizedBox(
            height: 10,
          ),
          normalText("Category: ${controller.category}")
        ],
      ),
    );
  }

  Widget secondChild() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          normalText("Choose the best match:"),
          SizedBox(height: 2.0),
          getSelectionRow(),
          SizedBox(
            height: 13,
          ),
          clickableText("New Pictures", (){
            setState(() {
              controller.onNewPicturesSelect();
            });})
        ],
      ),
    );
  }

  Widget getSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ()=>onImageSelect(controller.image1),
          child: Image.asset(controller.data[controller.image1]!),
        ),
        GestureDetector(
          onTap: ()=>onImageSelect(controller.image2),
          child: Image.asset(controller.data[controller.image2]!),
        ),
      ],
    );
  }

  onImageSelect(String imageName) {
    resultDialog(controller.isPresentInMap(imageName));
  }

   resultDialog(bool isSuccess) {
    String message = isSuccess
        ? "Congratulations! You are correct"
        : "Sorry! You are wrong";
    showDialog(context: _context!, builder: (context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.topCenter,
          child: Text("Thank You.",
                  style: TextStyle(color: Colors.black87, fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),
        content: Text(message,textAlign: TextAlign.center,),
        contentPadding: EdgeInsets.symmetric(vertical: 7.0),
        actions: [
              Divider(height: 7.0,),
              SizedBox(height:4.0),
              Center(
                child: clickableText("Ok",(){
                  Navigator.pop(context);
                }),
              )
        ],

      );
    });
  }


  Widget normalText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, color: Colors.black87),
    );
  }

  Widget clickableText(String text, VoidCallback onClick) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
      ),
      onTap: onClick,
    );
  }

   onSelectCategory(){
    showBottomSheet(context: context, builder: (context){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          normalText("Choose Category")
        ]..addAll(controller.categoryMap.keys.map((e) => Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: clickableText(e, () {
            setState(() {
              controller.setMainImage(localCategory: e);
              Navigator.pop(context);
            });
          }),
        )).toList()),
      );
    });
  }



}
