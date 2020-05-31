import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _DocumentScreen extends State<DocumentsScreen> {
  String imageUrlLogoRes="";
  setImageItem(imageUrl){
    this.imageUrlLogoRes = imageUrl;
  }

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Logo Restaurant");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setImageItem(fileURL);
      print(imageUrlLogoRes);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Documents Images",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: RaisedButton(
          color: Color.fromRGBO(141, 121, 70, 1.0),
          onPressed: () {
            getImage();
          },
          child: const Text(
            "Pick Logo",
            style: TextStyle(color: Colors.white),
          ),
          shape: OutlineInputBorder(
            borderSide:
            BorderSide(color: Color.fromRGBO(141, 121, 70, 1.0)),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
