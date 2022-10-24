import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/profile/ui/widgets/theme_mode_switch.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/loading_shader_shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final masterPoliciesProviderInstance = MasterPoliciesProvider.instance;
final appProviderInstance = AppProvider.instance;

class MasterPolicyListScreen extends ConsumerWidget {
  const MasterPolicyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterPolicies = ref
        .watch(masterPoliciesProviderInstance.policiesStreamer)
        .when(data: (policies) {
      return policies;
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
    return Scaffold(
      //TODO: Add BottomNavigationBar to all starting screens
      //Policies, Shop Policies and Profile
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Policies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Shop Policies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
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
                flexibleSpace: SafeArea(
                  child: LoadingShaderShimmer(
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
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(((context, index) {
                  return LoadingShaderShimmer(
                    isLoading: loading,
                    child: GestureDetector(
                      onTap: () {
                        final route = '${AppRoutes.policy.policyRoute}$index';
                        context.go(route);
                        ref.read(routeProvider.notifier).state = route;
                      },
                      child: Hero(
                        tag: 'master-policy $index',
                        child: Container(
                          margin: EdgeInsets.only(top: context.height * 0.028),
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
    );
  }
}
