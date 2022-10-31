import 'dart:async';

import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProviderInstance = AppProvider.instance;

class MasterPoliciesProvider {
  static final instance = MasterPoliciesProvider();

  final isLoading = StateProvider<bool>((ref) => true);

  final createMasterPolicyProvider = FutureProvider.family
      .autoDispose<void, MasterPolicyModel>((ref, masterPolicy) async {
    final database =
        ref.watch(databaseProviderInstance.appFirebaseDataBaseProvider);
    try {
      if (database != null) {
        await database.setMasterPolicyDocument(
          masterPolicy,
        );
      }
    } catch (e) {
      rethrow;
    }
  });

  final updateMasterPolicyProvider = FutureProvider.autoDispose
      .family<void, MasterPolicyModel>((ref, masterPolicy) async {
    final database =
        ref.watch(databaseProviderInstance.appFirebaseDataBaseProvider);
    try {
      if (database != null) {
        await database.updateMasterPolicyDocument(
          masterPolicy,
        );
      }
    } catch (e) {
      rethrow;
    }
  });

  //Uses a stream to obtain the master policies collection
  final policiesStreamer =
      StreamProvider.autoDispose<List<MasterPolicyModel>>((ref) {
    //Retrieves the database
    final database =
        ref.watch(databaseProviderInstance.appFirebaseDataBaseProvider);
    try {
      if (database != null) {
        ///If there is a database the collection of master policies of the user
        ///is called
        final collection = database.masterPolicyCollection();
        return collection;
      }

      ///If there is still no database the stream comes empty until a
      ///value changes
      return const Stream.empty();
    } catch (e) {
      //Any following error is forwarded
      rethrow;
    }
  });

  final loadingPolicies = StateProvider.autoDispose((ref) {
    ref.watch(MasterPoliciesProvider.instance.policiesStreamer.stream).listen(
        (policies) {
      Future.delayed(const Duration(seconds: 2), () {
        ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
            false;
        ref
            .watch(MasterPoliciesProvider.instance.masterPolicies.notifier)
            .state = policies;
      });
    }, onError: (_, __) {
      ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
          false;
    }, onDone: () {
      ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
          false;
    });
  });

  final masterPolicies = StateProvider<List<MasterPolicyModel>>((ref) => []);
}
