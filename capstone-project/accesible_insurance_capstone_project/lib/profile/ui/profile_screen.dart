import 'dart:convert';
import 'dart:io';

import 'package:accesible_insurance_capstone_project/profile/ui/widgets/theme_mode_switch.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/scaffold_navigation_bottom_bar.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
    final user =
        ref.read(AppProvider.instance.userProvider.notifier).auth.currentUser;
    return ScaffoldNavigationBottomBar(
      hasAppBar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ThemeModeSwitch(),
          SizedBox(
            height: context.height * 0.046,
          ),
          SizedBox(
            height: context.height * 0.32,
            width: context.width * 0.5,
            child: GestureDetector(
              onTap: _onChangeProfilePicture,
              child: Image.network(
                imageUrl,
                errorBuilder: ((context, error, stackTrace) {
                  return SizedBox(
                    width: context.height * 0.15,
                    height: context.height * 0.15,
                    child: SvgPicture.asset(
                      logo,
                      fit: BoxFit.contain,
                      color: Theme.of(context).primaryColor,
                      placeholderBuilder: (context) => const SizedBox(),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
