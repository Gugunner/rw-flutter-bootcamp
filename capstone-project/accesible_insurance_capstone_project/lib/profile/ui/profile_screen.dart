import 'dart:io';

import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/scaffold_navigation_bottom_bar.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/universal_constants.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<ProfileScreen> {
  String imageUrl = 'assets/images/life_image.png';

  void _onChangeProfilePicture() async {
    final storageRef = FirebaseStorage.instance.ref();
    final user =
        ref.read(AppProvider.instance.userProvider.notifier).auth.currentUser;
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      final imagesRef =
          storageRef.child('images/${user?.uid ?? 'anonymous'}/profile_pic');
      try {
        await imagesRef.putFile(
          File(file.path),
          SettableMetadata(
            contentType: 'image/jpg',
          ),
        );
        await setImgUrl();
      } on FirebaseException catch (e) {
        debugPrint('Could not upload image');
      }
    }
  }

  Future<void> setImgUrl() async {
    final storageRef = FirebaseStorage.instance.ref();
    final user =
        ref.read(AppProvider.instance.userProvider.notifier).auth.currentUser;
    if (user != null) {
      final refImageUrl = await storageRef
          .child('images/${user?.uid ?? 'anonymous'}/profile_pic')
          .getDownloadURL();
      setState(() {
        imageUrl = refImageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldNavigationBottomBar(
      hasAppBar: true,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.height * 0.0233,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height * 0.0233,
            ),
            Row(
              children: [
                SizedBox(
                  width: context.width * 0.0233,
                ),
                SizedBox(
                  width: context.height * 0.05,
                  height: context.height * 0.05,
                  child: SvgPicture.asset(
                    logo,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColor,
                    placeholderBuilder: (context) => const SizedBox(),
                  ),
                ),
                SizedBox(
                  width: context.width * 0.0233,
                ),
                Expanded(
                  child: Text(
                    EnglishCopies.logoName,
                    style: TextStyle(
                      fontFamily: UniversalConstants.chonburyFontFamily,
                      letterSpacing: 1.5,
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.9),
                          offset: const Offset(0.5, 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: context.width * 0.0233,
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.046,
            ),
            GestureDetector(
              onTap: _onChangeProfilePicture,
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: context.height * 0.2,
                    height: context.height * 0.21,
                  ),
                  Positioned(
                    left: context.height * 0.0125,
                    top: context.height * 0.0125,
                    child: Container(
                      width: context.height * 0.175,
                      height: context.height * 0.175,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                          strokeAlign: StrokeAlign.outside,
                        ),
                      ),
                      child: SizedBox(
                        width: context.height * 0.15,
                        height: context.height * 0.15,
                        child: Image.network(
                          imageUrl,
                          errorBuilder: ((context, error, stackTrace) {
                            return SizedBox(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Theme.of(context).primaryColor,
                                size: context.height * 0.1,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: context.height * 0.07,
                      child: Container(
                        width: context.height * 0.06,
                        height: context.height * 0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(Icons.edit),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.023,
            ),
            Text(
              (ref
                          .read(AppProvider.instance.userProvider.notifier)
                          .auth
                          .currentUser
                          ?.displayName ??
                      'User')
                  .toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: context.height * 0.011,
            ),
            Text(
              (ref
                          .read(AppProvider.instance.userProvider.notifier)
                          .auth
                          .currentUser
                          ?.uid ??
                      '')
                  .toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: context.height * 0.046,
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Icon(
                      Icons.phone_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Text(
                      'Contact us',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  height: context.height * 0.011,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Icon(
                      Icons.shield_moon_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Text(
                      'Privacy policy',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  height: context.height * 0.011,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Icon(
                      Icons.policy_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: context.width * 0.0233,
                    ),
                    Text(
                      'Terms and conditions',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  height: context.height * 0.011,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sign out',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    SharedPreferencesProvider.instance.clear();
                    ref.read(AppProvider.instance.signIn.state).state = false;
                    ref.read(routeProvider.notifier).state =
                        AppRoutes.signin.route;
                    ref
                        .read(DatabaseProvider
                            .instance.appFirebaseDataBaseProvider.state)
                        .state = null;
                    ref
                        .read(AppProvider.instance.userProvider.notifier)
                        .signOutFromGoogle();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconSize: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
