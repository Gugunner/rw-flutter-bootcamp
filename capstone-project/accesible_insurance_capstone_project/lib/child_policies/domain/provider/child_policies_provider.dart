import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final childPoliciesProviderInstance = ChildPoliciesProvider.instance;

///Handle any basic or advanced CRUD operations Provider for the
///child policies
class ChildPoliciesProvider {
  static final instance = ChildPoliciesProvider();

  final isLoading = StateProvider<bool>((ref) => true);

  final minimumPremiumPaid = StateProvider<double>((ref) => 0.0);

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

  final childPoliciesByPremiumPaidStreamer = StreamProvider.autoDispose
      .family<List<ChildPolicyModel>, String>((ref, masterPolicyId) {
    final database =
        ref.watch(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      final minimumPremiumPaid = ref
          .watch(ChildPoliciesProvider.instance.minimumPremiumPaid.state)
          .state;
      final childPolicies = database
          .watchAllChildPoliciesByMasterPolicyIdAndPremiumPaidRange(
              masterPolicyId, minimumPremiumPaid)
          .asBroadcastStream();
      return childPolicies;
    } catch (e) {
      rethrow;
    }
  });

  ///A simple select that watches for any change in the minimumPremium
  ///if the minimumPremium is bigger than 0 it uses a filtered query to 
  ///retrieve only child policies that have a premiumPaid equal or greater
  ///than the minimumPremium.
  final childPoliciesSelectStreamer = StreamProvider.autoDispose
      .family<List<ChildPolicyModel>, String>((ref, masterPolicyId) {
    try {
      final database =
          ref.watch(databaseProviderInstance.childPolicyDatabaseProvider);
      final minimumPremium = ref
          .watch(ChildPoliciesProvider.instance.minimumPremiumPaid.state)
          .state;
      Stream<List<ChildPolicyModel>> childPolicies;
      if (minimumPremium > 0) {
        childPolicies = database
            .watchAllChildPoliciesByMasterPolicyIdAndPremiumPaidRange(
                masterPolicyId, minimumPremium)
            .asBroadcastStream();
      } else {
        childPolicies = database
            .watchAllChildPoliciesByMasterPolicyId(masterPolicyId)
            .asBroadcastStream();
      }
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

  final childPolicyUpdateProvider = FutureProvider.autoDispose
      .family<void, ChildPolicyModel>((ref, childPolicy) {
    final database =
        ref.read(databaseProviderInstance.childPolicyDatabaseProvider);
    try {
      database.updateChildPolicy(childPolicy);
    } catch (e) {
      rethrow;
    }
  });
}
