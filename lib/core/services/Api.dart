import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getMatchHistoryCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getMatchById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeMatch(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addMatch(Map data) {
    return ref.add(data);
  }

  Future<void> updateMatch(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
