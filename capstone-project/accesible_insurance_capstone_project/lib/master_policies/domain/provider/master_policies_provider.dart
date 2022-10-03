import 'dart:async';

import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProviderInstance = AppProvider.instance;
final databaseProviderInstance = DatabaseProvider.instance;

class MasterPoliciesProvider {
  static final instance = MasterPoliciesProvider();

  final isLoading = StateProvider<bool>((ref) => true);

  //Uses a stream to obtain the master policies collection
  final policiesStreamer =
      StreamProvider.autoDispose<List<MasterPolicyModel>>((ref) {
    //Retrieves the database
    final database = ref.watch(databaseProviderInstance.masterPolicyDbProvider);
    try {
      if (database != null) {
        //If there is a database the collection of master policies of the user is called
        final collection = database.masterPolicyCollection();
        return collection;
      }
      //If there is still no database the stream comes empty until a value changes
      return const Stream.empty();
    } catch (e) {
      //Any following error is forwarded
      rethrow;
    }
  });

  final loadingPolicies = StateProvider.autoDispose((ref) {
    ref.watch(MasterPoliciesProvider.instance.policiesStreamer.stream).listen(
        (policies) {
        ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
            false;
    }, onError: (_, __) {
      ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
          false;
    }, onDone: () {
      ref.watch(MasterPoliciesProvider.instance.isLoading.notifier).state =
          false;
    });
  });
}
