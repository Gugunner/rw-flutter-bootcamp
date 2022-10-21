import 'package:accesible_insurance_capstone_project/child_policy/data/child_policy_database.dart';
import 'package:accesible_insurance_capstone_project/master_policy/data/master_policy_data_base.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/service/app_firestore_service.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProviderInstance = AppProvider.instance;
final databaseProviderInstance = DatabaseProvider.instance;

class DatabaseProvider {
  static final instance = DatabaseProvider();

  ///Returns a new instance of a [MasterPolicyDataBase] with
  ///the current userId and user the [AppFirestoreService] global
  ///instance.
  ///
  final masterPolicyDatabaseProvider =
      Provider.autoDispose<MasterPolicyDataBase?>((ref) {
    ///Checks for changes to the User in Firebase
    final user = ref.watch(appProviderInstance.authStateChangesProvider);

    ///Checks for any changes to the authorizationtoken of the user
    final token = ref.watch(appProviderInstance.authTokenProvider);
    final userValue = user.asData?.value;

    ///Checks if a user id and a token exists
    if (userValue != null) {
      if (userValue.uid.isNotEmpty) {
        final tokenValue = token.asData?.value;
        if (tokenValue != null && tokenValue.isNotEmpty) {
          //Returns a new instance of the [MasterPolicyDataBase]
          return MasterPolicyDataBase(
            uid: userValue.uid,
            firestoreService: AppFirestoreService.instance,
          );
        }
      }
    }
    return null;
  });

  final childPolicyDatabaseProvider = Provider<ChildPolicyDatabase>(
    (ref) => ChildPolicyDatabase(),
  );
}
