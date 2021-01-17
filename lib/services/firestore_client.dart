import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreClient {
  CollectionReference query = FirebaseFirestore.instance.collection('notes');

  void addNote(String idmuseum, String note) async {
    try {
      query.add({'idmuseum': '$idmuseum', 'note': '$note'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteNote(String iddoc) {
    try {
      query.doc(iddoc).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  void updateNote(String iddoc, String note) {
    try {
      query.doc(iddoc).update({'note': '$note'});
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot> getNotes(String idmuseum) {
    //return FirebaseFirestore.instance.collection('notes').where('idmuseum', isEqualTo: idmuseum).snapshots();
    return query.where('idmuseum', isEqualTo: idmuseum).snapshots();
  }

  Future<DocumentSnapshot> getNote(String iddoc) {
    return query.doc(iddoc).get();
  }
}
