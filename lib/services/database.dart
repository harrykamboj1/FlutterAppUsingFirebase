import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brew');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //userData from snapshot
  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid, snapshot['name'], snapshot['sugars'], snapshot['strength']);
  }

  //brew list from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  //get brew List
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map((userDataFromSnapshot));
  }
}
