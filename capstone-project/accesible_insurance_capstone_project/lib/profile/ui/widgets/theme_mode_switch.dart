import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/database_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/icons.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
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
        SizedBox(
          width: context.width * 0.0233,
        ),
        //Temporal button
        //TODO: Move logic to profile screen
        Text(
          'Sign out',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            SharedPreferencesProvider.instance.clear();
            ref.read(AppProvider.instance.signIn.state).state = false;
            ref.read(routeProvider.notifier).state = AppRoutes.signin.route;
            ref
                .read(
                    DatabaseProvider.instance.appFirebaseDataBaseProvider.state)
                .state = null;
            ref
                .read(AppProvider.instance.userProvider.notifier)
                .signOutFromGoogle();
          },
          icon: Icon(
            Icons.power_settings_new_rounded,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 24,
        ),
        const Expanded(child: SizedBox()),
        // Switch(
        //   activeColor: Colors.white,
        //   value: themeMode == ThemeMode.light,
        //   onChanged: (state) => _handleChange(state, ref),
        // ),
        // Icon(
        //   themeMode == ThemeMode.light
        //       ? AppIcons.ligthTheme
        //       : AppIcons.darkTheme,
        //   size: 32,
        // ),
      ],
    );
  }
}
