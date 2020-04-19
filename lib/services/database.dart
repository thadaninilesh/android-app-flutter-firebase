import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebaseapp/models/brew.dart';
import 'package:flutterfirebaseapp/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name' : name,
      'strength': strength
    });
  }

  // brewlist from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        uid: doc.data['uid'] ?? '',
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // user data from snapshots
  UserData _getUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: snapshot.data['uid'],
        name: snapshot.data['name'],
        strength: snapshot.data['strength'],
        sugars: snapshot.data['sugars']
    );
  }

  // get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((snapshot){
      return _brewListFromSnapshot(snapshot);
    });
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map((snapshot) {
      UserData data = _getUserDataFromSnapshot(snapshot);
      print (data.uid);
      return data;
    });
  }

}