import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gunnersservices/sharedScreens/Login.dart';
import 'package:gunnersservices/services/UserManagement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Signup();
  }
}

class _Signup extends State<Signup> {
  String userName;
  String _email;
  String _password;
  String _phone;
  String _birthDate;
  String _confirmPassword;
  String _gender;
  String type;
  String smsCode;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneCodeSent = '';
  int index = 0;
  int lengthPass = 0;


  void createUser() {

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((signedInUser) async {
      Firestore.instance
          .collection("users")
          .document(signedInUser.user.uid)
          .setData({
        'UserName': userName,
        'Email': _email,
        'Phone': _phone,
        'Birthdate': _birthDate,
        'Gender': _gender,
        'UserType': type,
        'Confirm Password': _confirmPassword,


      });

      FirebaseUser user = await  _auth.currentUser();
      user.sendEmailVerification();
      UserManagement().storeNewUser(signedInUser, context);

    }).catchError((e) {
      clearFields();
      Fluttertoast.showToast(
          msg: "The User is Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString());
    });
  }


  List<DropdownMenuItem<int>> listDrop = [];
  List<DropdownMenuItem<int>> listUser = [];
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _birthDateController = new TextEditingController();
  TextEditingController _confirmController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();

  void clearFields() {
    _emailController.text = "";
    _phoneController.text = "";
    _passwordController.text = "";
    _birthDateController.text = "";
    _confirmController.text = "";
    _userNameController.text = "";
    _gender = "";
    type = "";
  }

  void loadItem() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text("Male"),
      value: 1,
    ));

    listDrop.add(new DropdownMenuItem(
      child: new Text("Female"),
      value: 2,
    ));
  }

  void typeUser() {
    listUser = [];
    listUser.add(new DropdownMenuItem(
      child: new Text("Restaurant"),
      value: 0,
    ));

    listUser.add(new DropdownMenuItem(
      child: new Text("Supermarket"),
      value: 1,
    ));
    listUser.add(new DropdownMenuItem(
      child: new Text("Captain"),
      value: 2,
    ));
  }


  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _submitCommand() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _loginCommand();
    }
  }

  void _loginCommand() {
    final snackBar = SnackBar(
      content: Text('Email: $_email, Password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    loadItem();
    typeUser();
    return new Scaffold(
      key: scaffoldKey,
      body: new Container(
        color: Color.fromRGBO(32, 94, 109, 1.0),
        child: new Center(
          child: SingleChildScrollView(
            child: new Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              SizedBox(
                child: new Text(
                  "Sign Up with ",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      color: Color.fromRGBO(0, 0, 0, 1.0)),
                ),
                width: 350,
              ),
              SizedBox(
                child: new Text(
                  "Gunners",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      color: Color.fromRGBO(141, 121, 70, 1.0)),
                ),
                width: 350,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              new Card(
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Form(
                      key: formKey,
                      child: SizedBox(
                        child: new TextField(
                          controller: _userNameController,
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "UserName",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              icon: new Icon(
                                Icons.account_circle,
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                      child: new TextFormField(
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Email:",
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
                        validator: (val) => !EmailValidator.Validate(val,true)
                            ? 'Please provide a valid email' : null,
                        onSaved: (val) => _email = val,
                      ),
                      width: 350,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                      child: new TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          this._phone = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Phone Number",
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
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                      child: new TextField(
                        controller: _birthDateController,
                        onChanged: (value) {
                          setState(() {
                            _birthDate = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "BirthDate",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(141, 121, 70, 1.0)),
                          icon: new Icon(
                            Icons.date_range,
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
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                      child: new TextFormField(
                        controller: _passwordController,

                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password:",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(141, 121, 70, 1.0)),
                          icon: new Icon(
                            Icons.security,
                            color: Color.fromRGBO(141, 121, 70, 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(141, 121, 70, 1.0)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        validator: (val) =>
                        val.length < 7 ? 'Your password is too short.. ' : null,
                        onSaved: (val) => _password = val,


                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),

                      width: 350,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                      child: new TextField(
                        controller: _confirmController,
                        onChanged: (value) {
                          _confirmPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(141, 121, 70, 1.0)),
                          icon: new Icon(
                            Icons.security,
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
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 28),
                        ),
                        new Icon(
                          Icons.person,
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                        ),
                        SizedBox(
                          child: new DropdownButton(
                              items: listUser,
                              onChanged: (value) {
                                setState(() {
                                  if(value == 0){
                                    type = "Restaurant";
                                  } else if(value == 1) {
                                    type = "Supermarket";
                                  } else {
                                    type = "Captain";
                                  }
                                });
                              }),
                          width: 350,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30, left: 10, right: 10, bottom: 30),
                      child: GenderSelector(
                        onChanged: (value) {
                          setState(() {
                            if (value == Gender.FEMALE) {
                              _gender = "female";
                            } else {
                              _gender = "male";
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              new RaisedButton(
                  color: Color.fromRGBO(141, 121, 70, 1.0),
                  child: new Text("Sign Up"),
                  shape: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    //_submitCommand();
                    createUser();
                    //clearFields();
                  }),
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login()));

                },
                child: new Text("Already have an acount?"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
