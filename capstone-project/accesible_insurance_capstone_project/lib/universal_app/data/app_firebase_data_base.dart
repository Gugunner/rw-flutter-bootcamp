import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/service/app_firestore_service.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/firestore_paths.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/string_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppFirebaseDataBase {
  const AppFirebaseDataBase({
    required this.uid,
    required this.firestoreService,
  });

  final String uid;
  final AppFirestoreService firestoreService;

  Stream<List<MasterPolicyModel>> masterPolicyCollection() {
    var index = -1;
    final collectionPath = FireStorePaths.masterPolicies(uid);
    return firestoreService.collection(
      collectionPath: collectionPath,
      snapshotBuilder: ((snapshot, options) {
        index++;
        return MasterPolicyModel.fromFirestore(snapshot!, options, index);
      }),
    );
  }

  ///Creates a master policy following the specified document ref
  ///Creates a ref so if the path is not created it creates it first.
  Future<void> setMasterPolicyDocument(MasterPolicyModel masterPolicy) {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('master-policies')
        .doc();
    return firestoreService.setDocument(
      document: masterPolicy.toFirestore(),
      fromDocRef: docRef,
    );
  }

  ///Updates a document by merging new content with old content, uses a
  ///specific path, if the path is not there, it will throw an error.
  Future<void> updateMasterPolicyDocument(MasterPolicyModel masterPolicy) {
    if (masterPolicy.documentId.isNotNullOrEmpty) {
      final documentPath =
          FireStorePaths.mastePolicy(uid, masterPolicy.documentId!);
      return firestoreService.setDocument(
          document: masterPolicy.toFirestore(),
          path: documentPath,
          merge: true);
    }
    return Future.value();
  }
}
