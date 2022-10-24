import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({Key? key}) : super(key: key);

  ///Switches between light and dark mode and saves the state
  ///in SharedPreferences
  void _handleChange(bool state, WidgetRef ref) async {
    final theme = state ? ThemeMode.light : ThemeMode.dark;
    ref.read(appProviderInstance.themeProvider.notifier).state = theme;
    await SharedPreferencesProvider.instance.setTheme(theme);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appProviderInstance.themeProvider.state).state;
    return Row(
      children: [
        //Temporal button
        //TODO: Move logic to profile screen
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            SharedPreferencesProvider.instance.setIsSignedIn(false);
            ref.read(AppProvider.instance.signIn.state).state = false;
            ref.read(AppProvider.instance.firebaseAuthProvider).signOut();
            ref.read(routeProvider.notifier).state = AppRoutes.signin.route;
          },
          icon: const Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
          ),
          iconSize: 24,
        ),
        const Expanded(child: SizedBox()),
        Switch(
          activeColor: Colors.white,
          value: themeMode == ThemeMode.light,
          onChanged: (state) => _handleChange(state, ref),
        ),
        Icon(
          themeMode == ThemeMode.light
              ? AppIcons.ligthTheme
              : AppIcons.darkTheme,
          size: 32,
        ),
      ],
    );
  }
}
