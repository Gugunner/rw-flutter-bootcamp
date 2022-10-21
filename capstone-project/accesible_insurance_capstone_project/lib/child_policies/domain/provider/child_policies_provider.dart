import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final childPoliciesProviderInstance = ChildPoliciesProvider.instance;

class ChildPoliciesProvider {
  static final instance = ChildPoliciesProvider();

  final isLoading = StateProvider<bool>((ref) => true);

  final childPoliciesStreamer = StreamProvider.autoDispose
      .family<List<ChildPolicyModel>, String>((ref, masterPolicyId) {
    final database =
        ref.watch(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      final childPolicies = database
          .watchAllChildPoliciesByMasterPolicyId(masterPolicyId)
          .asBroadcastStream();
      return childPolicies;
    } catch (e) {
      rethrow;
    }
  });

  final childPolicyInsertProvider = FutureProvider.autoDispose
      .family<int, ChildPolicyModel>((ref, childPolicy) async {
    final database =
        ref.read(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      final id = await database.insertChildPolicy(childPolicy);
      return id;
    } catch (e) {
      rethrow;
    }
  });

  final childPolicyFindByIdProvider =
      FutureProvider.autoDispose.family<ChildPolicyModel, int>((ref, id) {
    final database =
        ref.read(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      return database.findChildPolicyById(id);
    } catch (e) {
      rethrow;
    }
  });

  final childPolicyDeleteProvider =
      FutureProvider.autoDispose.family<void, int>((ref, id) {
    final database =
        ref.read(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      database.deleteChildPolicy(id);
    } catch (e) {
      rethrow;
    }
  });
}
