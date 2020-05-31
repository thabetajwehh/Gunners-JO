import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/sharedScreens/DocumentsScreen.dart';
import 'package:gunnersservices/sharedScreens/Login.dart';
import 'package:gunnersservices/sharedScreens/Settings.dart';
import 'package:image_picker/image_picker.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainDrawer();
  }
}

class _MainDrawer extends State<MainDrawer> {
  String _image = "";
  String userName;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("tyuio");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        FirebaseAuth.instance.currentUser().then((signedInUser) {
          Firestore.instance
              .collection("users")
              .document(signedInUser.uid)
              .updateData({'imageUrl': fileURL}).then((v) {
            _image = fileURL;
          });
        });
      });
    });
  }

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
        String data2 = data.data['imageUrl'];
        userName = data.data['UserName'];

        if (data2 != null && data2.trim().length > 1)
          setState(() {
            _image = data2;
          });
        else
          setState(() {
            _image = "";
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(141, 121, 70, 1.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: FlatButton(
                    onPressed: () {
                      showImagePickOptions().then((value) => value != null
                          ? pickImageFrom(value)
                              .then((value) => changeFileSource(value))
                          : {print('empty')});
                    },
                    color: Color.fromRGBO(141, 121, 70, 1.0),
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
                      radius: 55.0,
                      child: GestureDetector(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: buildCachedNetworkImage(),
                        ),
                      ),
                    ),
                  ),
                  width: 200,
                ),
                Text(
                  '$userName',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Rate',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '5.0',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Color.fromRGBO(141, 121, 70, 1.0),
          ),
          title: Text(
            'Settings',
            style: TextStyle(
                fontSize: 18, color: Color.fromRGBO(141, 121, 70, 1.0)),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        ListTile(
            leading: Icon(
              Icons.attach_file,
              color: Color.fromRGBO(141, 121, 70, 1.0),
            ),
            title: Text(
              'Documents',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(141, 121, 70, 1.0)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DocumentsScreen()));
            }),
        ListTile(
            leading: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(141, 121, 70, 1.0),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(141, 121, 70, 1.0)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }),
      ],
    ));
  }

  Widget buildCachedNetworkImage() {
    if (_image.startsWith("/storage"))
      return Image.file(File(_image));
    else
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: _image,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Icon(Icons.person, color: Colors.white),
      );
  }

  Future<dynamic> showImagePickOptions() async {
    var pickMethodType;
    pickMethodType = showModalBottomSheet(
        context: this.context,
        builder: (BuildContext context) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                buildBottomSheetItem(
                    Icons.photo, 'Pick from gallery', ImageSource.gallery),
                buildBottomSheetItem(Icons.camera_enhance, 'Take a new photo',
                    ImageSource.camera),
              ],
            ),
          );
        });
    return pickMethodType;
  }

  ListTile buildBottomSheetItem(
      IconData photo, String data, ImageSource imageSource) {
    return ListTile(
        leading: new Icon(photo),
        title: new Text(data),
        onTap: () async {
          Navigator.pop(this.context, imageSource);
        });
  }

  Future<File> pickImageFrom(pickMethodType) async {
    var file = await ImagePicker.pickImage(source: pickMethodType);
    return file;
  }

  Widget BuildImage(image) {
    return image == null ? Text('No image selected.') : Image.file(image);
  }

  void changeFileSource(File file) {
    setState(() {
      _image = file.path;
    });
  }
}
