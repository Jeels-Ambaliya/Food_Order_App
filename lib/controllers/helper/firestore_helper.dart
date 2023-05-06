import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper firestoreHelper = FirestoreHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchRecords() {
    return db.collection("allFoods").snapshots();
  }
}
