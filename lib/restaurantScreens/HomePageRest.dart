import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/restaurantScreens/Menu.dart';
import 'package:gunnersservices/services/FireStoreServicesItemsSupermarket.dart';
import 'package:gunnersservices/services/ItemSuperMarket.dart';
import 'package:gunnersservices/services/UserInfoHandler.dart';
import 'package:gunnersservices/sharedScreens/ForgotScreen.dart';
import 'package:gunnersservices/services/Item.dart';
import 'package:gunnersservices/sharedScreens/MainDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';


class HomePageRest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageRest();
  }
}

class _HomePageRest extends State<HomePageRest> {
  String uid = '';
  String _image="";
  List<Item> items;
  FireStoreServiceItems fireServe;
  StreamSubscription<QuerySnapshot> todoItems;
  int i;
  bool delete = false;
  bool isExpanded = false;



  @override
  void initState() {

    String uid;
    FirebaseAuth.instance.currentUser().then((user){uid=user.uid;});
    fireServe = new FireStoreServiceItems(
        Firestore.instance.collection("users")
            .document(UserInfoHandler.uid).collection("Rest Menu"));
    items = new List();
    todoItems?.cancel();
    todoItems = fireServe.getItemList().listen((QuerySnapshot snapshot) {
      final List<Item> items = snapshot.documents
          .map((documentSnapshot) => Item.fromMap(documentSnapshot.data))
          .toList();
      FirebaseAuth.instance.currentUser().then((value) {
        setState(() {
          this.uid = value.uid;

        });
      }).catchError((e) {
        print(e);
      });
      setState(() {
        this.items = items;
        if (delete) {
          items.removeAt(i);
          delete = false;
        }
      });
    });



    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        title: Text('Home Page Restaurant'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Menu()));
        },
        label: Text("Add to Menu"),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
            if (index == 0) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageRest()));
            } else {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotScreen()));
            }
          });
        },
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              backgroundColor: Color.fromRGBO(141, 121, 70, 1.0)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: Text(
                'Notification',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color.fromRGBO(141, 121, 70, 1.0)),
        ],
      ),
      drawer: MainDrawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      key: Key(items[index].itemName),
                      onDismissed: (direction) {
                        setState(() {
                          Firestore.instance
                              .collection("Rest Menu")
                              .document(items[index].itemName)
                              .delete();
                          items.removeAt(index);
                        });
                      },
                      child: ExpansionTile(
                        onExpansionChanged: (bool){
                          setState(() {
                            isExpanded = bool;
                          });
                        },
                        title: Text('${items[index].itemName}',
                        style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                        ),
                        ),
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 50),),
                         Icon(Icons.fastfood),
                          ListTile(title: Text('Item Name: ${items[index].itemName}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Type: ${items[index].itemType}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Details: ${items[index].itemDetails}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Price: ${items[index].itemPrice}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Date: ${items[index].itemDate}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todoType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'snacks':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'pizza':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'rice':
        iconval = FontAwesomeIcons.dumbbell;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'shawarma':
        iconval = FontAwesomeIcons.glassCheers;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'others':
        iconval = FontAwesomeIcons.tasks;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child:
          Icon(iconval, color: Color.fromRGBO(141, 121, 70, 1.0), size: 20.0),
    );
  }
}
