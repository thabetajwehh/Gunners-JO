import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gunnersservices/HomePageCaptain.dart';
import 'package:gunnersservices/restaurantScreens/HomePageRest.dart';
import 'package:gunnersservices/services/UserInfoHandler.dart';
import 'package:gunnersservices/sharedScreens/ForgotScreen.dart';
import 'package:gunnersservices/sharedScreens/Signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../superMarketScreens/HomePageSuperMarket.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Login();
  }
}

class _Login extends State<Login> {
  String _email;
  String _password;
  String type;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((signedInUser) {
      Firestore.instance
          .collection("users")
          .document(signedInUser.uid)
          .get()
          .then((DocumentSnapshot data) {
        type = data.data['UserType'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        color: Color.fromRGBO(32, 94, 109, 1.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              new CircleAvatar(
                child: Image.asset('assets/images/gunnerssmal.jpg'),
                backgroundColor: Color.fromRGBO(32, 94, 109, 1.0),
                radius: 50.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Form(

                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      SizedBox(
                        child: new TextFormField(
                          onChanged: (value) {
                            setState((){
                              _email = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              icon: new Icon(
                                Icons.email,
                                color: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(141, 121, 70, 1.0)),
                                borderRadius: BorderRadius.circular(50),
                              )),
                          ),
                        width: 350,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      SizedBox(
                        child: new TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(141, 121, 70, 1.0)),
                            icon: new Icon(
                              Icons.phone_android,
                              color: Color.fromRGBO(141, 121, 70, 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),

                        ),
                        width: 350,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  width: double.infinity,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotScreen()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Color.fromRGBO(141, 121, 70, 1.0),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: new RaisedButton(
                    color: Color.fromRGBO(141, 121, 70, 1.0),
                    child: new Text("Login"),
                    shape: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      print(_email);
                      print(_password);
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((user) {

                            if(!user.user.isEmailVerified) {
                              Fluttertoast.showToast(
                                  msg: "Please verify your email");
                              return;
                            }
                             else {
                        UserInfoHandler.uid = user.user.uid;
                        if (type == "Restaurant") {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageRest()));
                        } else if (type == "Supermarket") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageSuperMarket()));
                        } else if (type == "Captain") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageCaptain()));
                        }
                      }}).catchError((e) {
                        print(e);
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  width: double.infinity,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(141, 121, 70, 1.0),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
