import 'package:accesible_insurance_capstone_project/child_policy/data/child_policy_database.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/app_firebase_data_base.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/service/app_firestore_service.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProviderInstance = AppProvider.instance;
final databaseProviderInstance = DatabaseProvider.instance;

class DatabaseProvider {
  static final instance = DatabaseProvider();

  final appFirebaseDataBaseProvider =
      StateProvider<AppFirebaseDataBase?>((ref) => null);

  ///Returns a new instance of a [AppFirebaseDataBase] with
  ///the current userId and user the [AppFirestoreService] global
  ///instance.
  ///
  final initializeFirebaseDatabaseProvider =
      FutureProvider.autoDispose<AppFirebaseDataBase?>((ref) {
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
          final db = AppFirebaseDataBase(
            uid: userValue.uid,
            firestoreService: AppFirestoreService.instance,
          );

          return db;
        }
      }
    }
    return null;
  });

  final loadingDatabase = StateProvider.autoDispose((ref) {
    ref
        .watch(DatabaseProvider.instance.initializeFirebaseDatabaseProvider)
        .when(data: (data) {
      print('Firebase DataBase initialized');
      if (data != null &&
          ref
                  .read(DatabaseProvider
                      .instance.appFirebaseDataBaseProvider.state)
                  .state ==
              null) {
        Future.delayed(
            const Duration(
              milliseconds: 200,
            ),
            () => ref
                .read(DatabaseProvider
                    .instance.appFirebaseDataBaseProvider.notifier)
                .state = data);
      }
    }, error: (error, stackTrace) {
      print('Could not initialize Firebase DataBase - ${error.toString()}');
    }, loading: () {
      print('loading');
    });
  });

  ///Manages the instance of the ChildPolicyDatabase
  final childPolicyDatabaseProvider = Provider<ChildPolicyDatabase>(
    (ref) => ChildPolicyDatabase(),
  );
}
