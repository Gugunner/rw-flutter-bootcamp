import 'package:cloud_firestore/cloud_firestore.dart';

class AppFirestoreService {
  static final instance = AppFirestoreService();

  /// Returns a stream for a FirestoreCollection of Type.
  /// 
  /// Use the [snapshotBuilder] to pass a fromFirestore factory method
  /// from the model. For reference check the official documentation
  /// https://firebase.google.com/docs/firestore/query-data/get-data#custom_objects
  /// 
  /// A [queryBuilder] can be called by calling the [where] method of a 
  /// [CollectionReference] for example ```collectionRef.where('currentSI', isGreaterThan: 2000)```
  /// Since it is a closure the ref is obtained inside this method so there is no need
  /// to get the reference before.
  Stream<List<T>> collection<T>({
    required String collectionPath,
    required T Function(DocumentSnapshot<Map<String, dynamic>>? snapshot,
            SnapshotOptions? options)
        snapshotBuilder,
    CollectionReference<Map<String, dynamic>> Function(
            CollectionReference<Map<String, dynamic>>? query)?
        queryBuilder,
  }) {
    ///Obtains the [CollectionReference] with the query formed
    CollectionReference<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(collectionPath);
    //If a [queryBuilder] is passed the new formed compound query is returned
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    //Retrieves only documents inside the collection that exist
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs
          .where((document) => document.exists)
          //Snapshot options are passed by default
          .map((document) => snapshotBuilder(document, SnapshotOptions()))
          .toList();
    });
  }
}
