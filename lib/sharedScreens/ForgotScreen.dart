import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgotScreen();
  }

}


class _ForgotScreen extends State<ForgotScreen> {
  String email = "";
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        title: Text('Forgotten Screen', style: TextStyle(color: Colors.white
        ),
      ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Form(
            key: _formKey,

            child: Column(
              children: <Widget>[
                Text('We Will mail you a link ... \nPlease click on that link to reset your password',
                style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0),
                fontWeight: FontWeight.bold),
                ),
                Theme(
                  data: ThemeData(
                    hintColor: Color.fromRGBO(141, 121, 70, 1.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please enter your email';
                        }
                        else {
                          email = value;
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Color.fromRGBO(141, 121, 70, 1.0),
                      ),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0),width: 1)
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0),width: 1)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0),width: 1)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0),width: 1)
                        ),
                      ),
                    ),
                  ),
                ),

                Padding
                  (padding: (EdgeInsets.only(top: 20,left: 30, right: 30)),
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => print('Check your mails'));
                      }
                    },

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color.fromRGBO(141, 121, 70, 1.0),
                    child: Text('Send Email', style: TextStyle(color: Colors.white,
                    ),),
                    padding: EdgeInsets.all(10),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

}