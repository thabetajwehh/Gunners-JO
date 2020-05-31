import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/sharedScreens/ForgotScreen.dart';


class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Settings();
  }
}

class _Settings extends State<Settings> {

  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.all(8.0),
                  color: Color.fromRGBO(141, 121, 70, 1.0),
                  child: ListTile(
                    onTap: null,
                    title: Text(
                      "Username",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    leading: SizedBox(
                      child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
                          radius: 55.0,
                          child: Icon(Icons.person, color:Colors.white,),
                        ),
                      ),
                      width: 50,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Color.fromRGBO(141, 121, 70, 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        title: Text("Change Password", style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0)),),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen()));
                        },
                      ),
                      _builDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        title: Text("Change Language", style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0)),),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      _builDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                        ),
                        title: Text("Change Location", style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0)),),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Notification Setting",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(141, 121, 70, 1.0)),
                ),
                SwitchListTile(
                  dense: true,
                  activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Recieved Notification", style: TextStyle(color: Color.fromRGBO(141, 121, 70, 1.0)),),
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container _builDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
}
