import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gunnersservices/services/UserInfoHandler.dart';
import 'package:gunnersservices/superMarketScreens/HomePageSuperMarket.dart';
import 'package:image_picker/image_picker.dart';

class MenuSupermarket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState c`
    return _MenuSupermarket();
  }
}

class _MenuSupermarket extends State<MenuSupermarket> {
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemDetailsController = new TextEditingController();
  TextEditingController _itemDateController = new TextEditingController();
  TextEditingController _itemPriceController = new TextEditingController();

  String itemName, itemDetails, itemDate;
  dynamic itemPrice;
  String imageUrl="";

  setItemName(itemName) {
    this.itemName = itemName;
  }

  setItemDetails(itemDetails) {
    this.itemDetails = itemDetails;
  }

  setItemDate(itemDate) {
    this.itemDate = itemDate;
  }

  setItemPrice(itemPrice) {
    this.itemPrice = itemPrice;
  }

  setImageItem(imageUrl){
    this.imageUrl = imageUrl;
  }

  int _myItemType = 0;
  String itemVal;

  void _handleItemType(int value) {
    setState(() {
      _myItemType = value;
      switch (_myItemType) {
        case 1:
          itemVal = 'cannedFood';
          break;
        case 2:
          itemVal = 'cheeseAndMilk';
          break;
        case 3:
          itemVal = 'softDrink';
          break;
        case 4:
          itemVal = 'legumes';
          break;
        case 5:
          itemVal = 'others';
          break;
      }
    });
  }

  createData() {
    String uid;
    uid = getCurrentUid(uid);
    DocumentReference documentReference =
    Firestore.instance.collection('users').document(UserInfoHandler.uid).collection("Supermarket Menu").document(itemName);

    Map<String, String> items = {
      "itemName": itemName,
      "itemDetails": itemDetails,
      "itemDate": itemDate,
      "itemType": itemVal,
      "itemPrice": itemPrice,
      "imageUrl": imageUrl,
    };
    documentReference.setData(items).whenComplete(() {
      setState(() {
        clearFields();
        Fluttertoast.showToast(
            msg: "The Item is Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
            textColor: Colors.white,
            fontSize: 16.0);
      });
    });
  }

  String getCurrentUid(String uid) {
    FirebaseAuth.instance.currentUser().then((user){
      uid=user.uid;
    });
    return uid;
  }

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("tyuio");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setImageItem(fileURL);
      print(imageUrl);}
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        title: Text('Add Item Supermarket'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15),
                  child: TextField(
                    onChanged: (String name) {
                      setItemName(name);
                    },
                    controller: _itemNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Item:",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(141, 121, 70, 1.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (String itemDetails) {
                      setItemDetails(itemDetails);
                    },
                    controller: _itemDetailsController,

                    decoration: InputDecoration(hintText: "Details:",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(141, 121, 70, 1.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
                  child: TextField(
                    onChanged: (String itemDate) {
                      setItemDate(itemDate);
                    },
                    keyboardType: TextInputType.datetime,
                    controller: _itemDateController,
                    decoration: InputDecoration(hintText: "Date:",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(141, 121, 70, 1.0)
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (dynamic itemPrice) {
                      setItemPrice(itemPrice);
                    },
                    controller: _itemPriceController,
                    decoration: InputDecoration(hintText: "Price:",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(141, 121, 70, 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'Select Item Type',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(141, 121, 70, 1.0)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myItemType,
                          onChanged: _handleItemType,
                          activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Text("Canned Food", style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(141, 121, 70, 1.0))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myItemType,
                          onChanged: _handleItemType,
                          activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Text("Cheese And Milk", style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(141, 121, 70, 1.0))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myItemType,
                          onChanged: _handleItemType,
                          activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Text("Soft Drink", style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(141, 121, 70, 1.0))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myItemType,
                          onChanged: _handleItemType,
                          activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Text("Legumes", style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(141, 121, 70, 1.0))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _myItemType,
                          onChanged: _handleItemType,
                          activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Text("Others",
                          style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(141, 121, 70, 1.0)),),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color.fromRGBO(141, 121, 70, 1.0),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageSuperMarket()));
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    RaisedButton(
                      color: Color.fromRGBO(141, 121, 70, 1.0),
                      onPressed: () {
                        createData();
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    RaisedButton(
                      color: Color.fromRGBO(141, 121, 70, 1.0),
                      onPressed: () {
                        getImage();
                      },
                      child: const Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void clearFields() {
    _itemPriceController.text = "";
    _itemDateController.text = "";
    _itemNameController.text = "";
    _itemDetailsController.text = "";
    _handleItemType(0);
  }
}
