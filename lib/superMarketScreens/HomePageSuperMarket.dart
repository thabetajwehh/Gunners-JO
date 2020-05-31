import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/services/UserInfoHandler.dart';
import 'package:gunnersservices/sharedScreens/ForgotScreen.dart';
import 'package:gunnersservices/sharedScreens/MainDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunnersservices/superMarketScreens/MenuSupermarket.dart';
import 'file:///C:/Users/thabe/OneDrive/Desktop/gunners_services/lib/services/FireStoreServicesItemsSupermarket.dart';
import 'file:///C:/Users/thabe/OneDrive/Desktop/gunners_services/lib/services/ItemSuperMarket.dart';

class HomePageSuperMarket extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageSuperMarket();
  }
}

class _HomePageSuperMarket extends State<HomePageSuperMarket> {
  String uid = '';
  List<ItemSuperMarket> itemsSupermarket;
  FireStoreServiceItems fireServeSupermarket;
  StreamSubscription<QuerySnapshot> todoItems;
  int i  ;
  bool delete = false;
  bool isExpanded = false;

  @override
  void initState() {
    String uid;
    FirebaseAuth.instance.currentUser().then((user){uid=user.uid;});
    fireServeSupermarket = new FireStoreServiceItems(
        Firestore.instance.collection("users")
            .document(UserInfoHandler.uid).collection("Supermarket Menu"));
    itemsSupermarket = new List();
    todoItems?.cancel();
    todoItems = fireServeSupermarket.getItemList().listen((QuerySnapshot snapshot) {
      final List<ItemSuperMarket> items = snapshot.documents
          .map((documentSnapshot) => ItemSuperMarket.fromMap(documentSnapshot.data))
          .toList();
      FirebaseAuth.instance.currentUser().then((value) {
        setState(() {
          this.uid = value.uid;
        });
      }).catchError((e) {
        print(e);
      });
      setState(() {
        this.itemsSupermarket = items;
        if(delete){
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
        title: Text('Home Page Supermarket'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MenuSupermarket()));
        },
        label: Text("Add to Menu"),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index){
          setState(() {
            this.index= index;
            if(index == 0){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePageSuperMarket()));
            }
            else {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ForgotScreen()));
            }
          });
        },
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        items: [
          BottomNavigationBarItem(

              icon: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              backgroundColor: Color.fromRGBO(141, 121, 70, 1.0)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.white,),
              title: Text('Notification', style: TextStyle(color: Colors.white),),
              backgroundColor: Color.fromRGBO(141, 121, 70, 1.0)
          ),
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
                  itemCount: itemsSupermarket.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      key: Key(itemsSupermarket[index].itemName),
                      onDismissed: (direction) {
                        setState(() {
                          Firestore.instance
                              .collection("Supermarket Menu")
                              .document(itemsSupermarket[index].itemName)
                              .delete();
                          itemsSupermarket.removeAt(index);
                        });
                      },
                      child: ExpansionTile(
                        onExpansionChanged: (bool){
                          setState(() {
                            isExpanded = bool;
                          });
                        },
                        title: Text('${itemsSupermarket[index].itemName}',
                          style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 50),),
                          Icon(Icons.fastfood, size: 50,color: Color.fromRGBO(141, 121, 70, 1.0),),
                          ListTile(title: Text('Item Name: ${itemsSupermarket[index].itemName}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Type: ${itemsSupermarket[index].itemType}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Details: ${itemsSupermarket[index].itemDetails}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Price: ${itemsSupermarket[index].itemPrice}',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    141, 121, 70, 1.0),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),),),
                          ListTile(title: Text('Item Date: ${itemsSupermarket[index].itemDate}',
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
      case 'cannedFood':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'cheeseAndMilk':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'softDrink':
        iconval = FontAwesomeIcons.dumbbell;
        colorval = Color.fromRGBO(141, 121, 70, 1.0);
        break;
      case 'legumes':
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
