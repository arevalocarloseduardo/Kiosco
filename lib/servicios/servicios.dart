import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Stream<QuerySnapshot> getLocations() {
    return Firestore.instance.collection('locations').snapshots();
  }

  Stream<QuerySnapshot> getCities() {
    return Firestore.instance
        .collection('cities')
        .orderBy('newPrice')
        .snapshots();
  }
  Stream<QuerySnapshot> getDeals() {
    return Firestore.instance.collection('deals').snapshots();
  }
}