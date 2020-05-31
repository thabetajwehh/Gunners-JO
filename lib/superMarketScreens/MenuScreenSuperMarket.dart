import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gunnersservices/superMarketScreens/HomePageSuperMarket.dart';
import 'file:///C:/Users/thabe/OneDrive/Desktop/gunners_services/lib/services/ItemSuperMarket.dart';

class MenuScreenRest extends StatefulWidget {
  final ItemSuperMarket itemSuperMarket;
  MenuScreenRest(this.itemSuperMarket);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MenuScreenRest();
  }
}

class _MenuScreenRest extends State<MenuScreenRest> {
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemDetailsController = new TextEditingController();
  TextEditingController _itemDateController = new TextEditingController();
  TextEditingController _itemTypeController = new TextEditingController();

  int _myItemType = 0;
  String itemVal;
  bool validate = false;
  get fireServeSupermarket => null;

  void _handleItemType(int value){
    setState(() {
      _myItemType = value;
      switch(_myItemType){
        case 1:
          itemVal = 'CannedFood';
          break;
        case 2:
          itemVal = 'CheeseAndMilk';
          break;
        case 3:
          itemVal = 'SoftDrinks';
          break;
        case 4:
          itemVal = 'Legumes';
          break;
        case 5:
          itemVal = 'others';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _itemNameController = new TextEditingController(text: widget.itemSuperMarket.itemName);
    _itemDetailsController = new TextEditingController(text: widget.itemSuperMarket.itemDetails);
    _itemDateController = new TextEditingController(text: widget.itemSuperMarket.itemDetails);
    _itemTypeController = new TextEditingController(text: widget.itemSuperMarket.itemType);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(141, 121, 70, 1.0),
          title: Text('Menu Items'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: _itemNameController,
                        decoration: InputDecoration(labelText: 'Item:'),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        controller: _itemDetailsController,
                        decoration: InputDecoration(labelText: 'Details:'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        controller: _itemDateController,
                        decoration: InputDecoration(labelText: 'Date:'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        controller: _itemTypeController,
                        decoration: InputDecoration(labelText: 'Type:'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Select Item Type',
                        style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: _myItemType,
                                onChanged: _handleItemType,
                                activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              Text(
                                'Canned Food', style: TextStyle(fontSize: 16.0,
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 2,
                                groupValue: _myItemType,
                                onChanged: _handleItemType,
                                activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              Text(
                                'Cheese And Milk', style: TextStyle(fontSize: 16.0,
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 3,
                                groupValue: _myItemType,
                                onChanged: _handleItemType,
                                activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              Text(
                                'Soft Drinks', style: TextStyle(fontSize: 16.0,
                                  color: Color.fromRGBO(141, 121, 70, 1.0)
                              ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 4,
                                groupValue: _myItemType,
                                onChanged: _handleItemType,
                                activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              Text(
                                'Legumes', style: TextStyle(fontSize: 16.0,
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              ),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 5,
                                groupValue: _myItemType,
                                onChanged: _handleItemType,
                                activeColor: Color.fromRGBO(141, 121, 70, 1.0),
                              ),
                              Text(
                                'Others', style: TextStyle(fontSize: 16.0,
                                  color: Color.fromRGBO(141, 121, 70, 1.0)),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePageSuperMarket()));
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          color: Color.fromRGBO(141, 121, 70, 1.0),
                          onPressed: (){
                            fireServeSupermarket.createMenuSupermarketItem(
                                _itemNameController.text,
                                _itemDetailsController.text,
                                _itemDateController.text,
                                _itemTypeController.text);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
