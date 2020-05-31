import 'package:cloud_firestore/cloud_firestore.dart';

import 'Item.dart';


class FireStoreServiceItems {
  CollectionReference collectionReference;
  FireStoreServiceItems(this.collectionReference);

  Future<Item> createMenuItem(String itemName, String itemDetails,
      String itemDate, String itemType, String itemPrice, String imageUrl) async {
    final TransactionHandler transactionHandler = (Transaction tx) async {
      final DocumentSnapshot documentSnapshot = await tx.get(
          collectionReference.document());

      final Item item = Item(itemName, itemDetails, itemDate, itemType, itemPrice, imageUrl);
      final Map<String, dynamic> data = item.toMap();
      await tx.set(documentSnapshot.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(transactionHandler).then((
        mapData) {
      return Item.fromMap(mapData);
    }).catchError((onError) {
      print('error: $onError');
      return null;
    });
  }

  Stream<QuerySnapshot> getItemList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = collectionReference.snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

}