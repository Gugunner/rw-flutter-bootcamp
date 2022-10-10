import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/master_policy_screen.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/loading_shader_shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/icons.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final masterPoliciesProviderInstance = MasterPoliciesProvider.instance;
final appProviderInstance = AppProvider.instance;

class MasterPolicyListScreen extends ConsumerWidget {
  const MasterPolicyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MasterPolicyModel> masterPolicies = ref
        .watch(masterPoliciesProviderInstance.policiesStreamer)
        .when(data: (p) {
      return p;
    }, error: (error, __) {
      debugPrint('error');
      return [];
    }, loading: () {
      debugPrint('loading');
      return [];
    });
    ref.watch(masterPoliciesProviderInstance.loadingPolicies);
    final loading =
        ref.watch(masterPoliciesProviderInstance.isLoading.state).state;
    return SafeArea(
      child: Scaffold(
        body: IgnorePointer(
          ignoring: loading,
          child: Shimmer(
            linearGradient: AppColors.shimmerGradient,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: loading ? Colors.transparent : null,
                  toolbarHeight: context.height * 0.056,
                  pinned: true,
                  floating: true,
                  expandedHeight: context.height * 0.112,
                  collapsedHeight: context.height * 0.077,
                  flexibleSpace: LoadingShaderShimmer(
                    isLoading: loading,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      width: context.width,
                      child: Column(
                        children: const [
                          ThemeModeSwitch(),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(((context, index) {
                    return LoadingShaderShimmer(
                      isLoading: loading,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 800),
                                  pageBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                  ) {
                                    return MasterPolicyScreen(
                                      masterPolicy: masterPolicies[index],
                                      index: index,
                                    );
                                  }));
                        },
                        child: Hero(
                          tag: 'master-policy $index',
                          child: Container(
                            margin:
                                EdgeInsets.only(top: context.height * 0.028),
                            child: MasterPolicyCard(
                              masterPolicy: masterPolicies[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }), childCount: masterPolicies.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({Key? key}) : super(key: key);

  void _handleChange(bool state, WidgetRef ref) =>
      ref.read(appProviderInstance.themeProvider.notifier).state =
          state ? ThemeMode.light : ThemeMode.dark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appProviderInstance.themeProvider.state).state;
    return Row(
      children: [
        //Temporal button
        //TODO: Delete and add logic in profile screen
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            SharedPreferencesProvider.instance.setIsSignedIn(false);
            //TODO: Add Firebase signout logic
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
