import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/sqlite/database_helper.dart';

class ChildPolicyDatabase {
  ChildPolicyDatabase();

  final dbHelper = DatabaseHelper.instance;

  Future<List<ChildPolicyModel>> findAllChildPoliciesByMasterPolicyId(
      masterPolicyId) {
    return dbHelper.findAllChildPoliciesByMasterPolicyId(masterPolicyId);
  }

  Stream<List<ChildPolicyModel>> watchAllChildPoliciesByMasterPolicyId(
      masterPolicyId) {
    return dbHelper
        .watchAllChildPoliciesByMasterPolicyId(masterPolicyId)
        .asBroadcastStream();
  }

  Future<ChildPolicyModel> findChildPolicyById(int id) {
    return dbHelper.findChilPolicyById(id);
  }

  Future<int> insertChildPolicy(ChildPolicyModel childPolicy) {
    return Future(() {
      return dbHelper.insertChildPolicy(childPolicy);
    });
  }

  Future<void> deleteChildPolicy(int id) {
    dbHelper.deleteChildPolicy(id);
    return Future.value();
  }

  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  void close() {
    dbHelper.close();
  }
}
