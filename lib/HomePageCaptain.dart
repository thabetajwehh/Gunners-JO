import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageCaptain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageCaptain();
  }
}

class _HomePageCaptain extends State<HomePageCaptain> {
  GoogleMapController mapController;
  String searchAddress;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[

          GoogleMap(
            onMapCreated: onMapCreated,

                initialCameraPosition: CameraPosition(
                    target: LatLng(40.7128, -74.0060), zoom: 10.0),
          ),

          Positioned(
            top: 30,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton (
                      icon: Icon(Icons.search),
                      onPressed: (){},
                      iconSize: 30.0),
                ),
                onChanged: (val) {
                  setState(() {
                    searchAddress = val;
                  });
                },
              ),
            ),
          ),

    ],
    ),);

  }
  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }
}