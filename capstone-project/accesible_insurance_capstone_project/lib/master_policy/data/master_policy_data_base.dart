import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/service/app_firestore_service.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/firestore_paths.dart';

class MasterPolicyDataBase {
  const MasterPolicyDataBase({
    required this.uid,
    required this.firestoreService,
  });

  final String uid;
  final AppFirestoreService firestoreService;

  Stream<List<MasterPolicyModel>> 
  masterPolicyCollection() {
    final collectionPath = FireStorePaths.allMasterPolicies(uid);
    return firestoreService.collection(
      collectionPath: collectionPath,
      snapshotBuilder: ((snapshot, options) =>
          MasterPolicyModel.fromFirestore(snapshot!, options)),
    );
  }
}
