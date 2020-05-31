import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGesture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageGesture();
}

class _ImageGesture extends State<ImageGesture> {
  File _frontImage;

  File get frontImage => _frontImage;

  set frontImage(File value) {
    _frontImage = value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTextDivider('Front image'),
            buildGestureDetector(frontImage, 'front'),
          ],
        ),
      ),
    );
  }

  Widget buildGestureDetector(File image, String type) {
    return FlatButton(
      onPressed: () {
        showImagePickOptions().then((value) => value != null
            ? pickImageFrom(value)
                .then((value) => changeFileSource('front', value))
            : {print('empty')});
      },
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(this.context).size.width - 24.0,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(child: BuildImage(image)),
        ),
      ),
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

  Column buildTextDivider(String data) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.teal,
        ),
        Center(
          child: Text(
            data,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 24),
          ),
        ),
        Divider(
          color: Colors.teal,
        ),
      ],
    );
  }

  void exit() {
    Navigator.pop(context);
  }

  void changeFileSource(imageType, file) {
    if (file != null)
      setState(() {
        if (imageType == 'front') _frontImage = file;
      });
  }
}
