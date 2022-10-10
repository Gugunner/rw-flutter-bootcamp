// import 'package:accesible_insurance_capstone_project/main.dart';
// import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// // ignore: depend_on_referenced_packages
// import 'package:google_sign_in/google_sign_in.dart';

// void main() async {
//   const uid = 'rquNKEPunYhcsK0o59SHuECM3al3';
//   const pid = 'qfrgafACPuaYdGnVVTaE';

//   final firestoreInstance = FakeFirebaseFirestore();
//   await firestoreInstance
//       .collection('users')
//       .doc(uid)
//       .collection('master-policies')
//       .doc(pid)
//       .set(
//     {
//       'activeSince': 'October 2, 2022 at 11:11:04 AM UTC-5',
//       'currentSI': 2089,
//       'expires': 'April 19, 2023 at 5:15:50 PM UTC-5',
//       'location': {
//         'country': 'Mexico',
//         'state': 'Jalisco',
//         'city': 'Huentitan',
//       },
//       'name': "Mama's home in Jalisco",
//       'policyId': 'AAA',
//       'roomDescription': {
//         'bathroom': 2,
//         'bedroom': 2,
//       },
//       'status': 'active',
//       'type': 'property',
//     },
//   );
//   final snapshot = await firestoreInstance
//       .collection('users')
//       .doc(uid)
//       .collection('master-policies')
//       .get();

//   const fakeEmail = 'test@yopmail.com';
//   const fakePassword = 'Test#1234';
//   // const uid = 'rquNKEPunYhcsK0o59SHuECM3al3';
//   final mockUser = MockUser(
//     isAnonymous: false,
//     uid: uid,
//     email: fakeEmail,
//   );
//   final auth = MockFirebaseAuth(
//     mockUser: mockUser,
//   );

//   // print(snapshot.docs.length);
//   // print(snapshot.docs.first.id);
//   // print(snapshot.docs.first.get('location'));
//   // print(snapshot.docs.first.get('location')['country']);
//   // print(snapshot.docs.first.get('activeSince'));
//   // print(firestoreInstance.dump());

//   final appProviderInstance = AppProvider.instance;

//   testWidgets('when retrieving the first master policy, the pid is $pid',
//       (tester) async {
//     final fakeFirebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);
//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           appProviderInstance.firebaseAuthProvider
//               .overrideWithProvider(fakeFirebaseAuthProvider),
//         ],
//         child: const MyApp(),
//       ),
//     );
//   });
// }

// Future<GoogleSignInAccount?> getWith(
//         {required MockGoogleSignIn mockGoogleSignIn}) async =>
//     await mockGoogleSignIn.signIn();
