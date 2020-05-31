import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/restaurantScreens/HomePageRest.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance.collection('/user').add({
      'email': user.email,
      'uid': user.uid,
    }).then((value) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePageRest()));
    }).catchError((e) {
      print(e);
    });
  }
}
