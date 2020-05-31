class ItemSuperMarket {
  String _itemName;
  String _itemDetails;
  String _itemDate;
  String _itemType;
  String _itemPrice;
  String _imageUrl;


  ItemSuperMarket(this._itemName, this._itemDetails,
      this._itemDate, this._itemType,
      this._itemPrice, this._imageUrl,
      );

  ItemSuperMarket.map(dynamic obj) {
    this._itemName = obj ['itemName'];
    this._itemDetails = obj ['itemDetails'];
    this._itemDate = obj ['itemDate'];
    this._itemType = obj ['itemType'];
    this._itemPrice = obj['itemPrice'];
    this._imageUrl = obj['imageUrl'];

  }
  String get itemName=> _itemName;
  String get itemDetails=> _itemDetails;
  String get itemDate=> _itemDate;
  String get itemType=> _itemType;
  String get itemPrice=> _itemPrice;
  String get imageUrl => _imageUrl;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['itemName'] = _itemName;
    map['itemDetails'] = _itemDetails;
    map['itemDate'] = _itemDate;
    map['itemType'] = _itemType;
    map['itemPrice'] = _itemPrice;
    map['imageUrl'] = _imageUrl;
    return map;
  }

  ItemSuperMarket.fromMap(Map<String,dynamic> map) {
    this._itemName = map['itemName'];
    this._itemDetails = map['itemDetails'];
    this._itemDate = map['itemDate'];
    this._itemType = map['itemType'];
    this._itemPrice = map['itemPrice'];
    this._imageUrl = map['imageUrl'];

  }
}