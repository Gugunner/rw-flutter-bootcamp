import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/scaffold_navigation_bottom_bar.dart';
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
    final searchedMasterPolicies = ref
        .watch(MasterPoliciesProvider.instance.searchedMasterPolicies.state)
        .state;
    final allMasterPolicies =
        ref.watch(MasterPoliciesProvider.instance.masterPolicies.state).state;
    final currentMasterPolicies = searchedMasterPolicies ?? allMasterPolicies;
    ref.watch(masterPoliciesProviderInstance.loadingPolicies);
    final loading =
        ref.watch(masterPoliciesProviderInstance.isLoading.state).state;
    return ScaffoldNavigationBottomBar(
      child: SafeArea(
        child: IgnorePointer(
          ignoring: loading,
          child: Shimmer(
            linearGradient: AppColors.shimmerGradient,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: <Widget>[
                SliverAppBar(
                  forceElevated: false,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: loading
                      ? Colors.transparent
                      : Theme.of(context).primaryColor,
                  toolbarHeight: context.height * 0.026,
                  pinned: true,
                  floating: true,
                  snap: true,
                  expandedHeight: context.height * 0.164,
                  collapsedHeight: context.height * 0.037,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: LoadingShaderShimmer(
                      isLoading: loading,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            SizedBox(
                              width: context.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      final route = AppRoutes.profile.route;
                                      ref.read(routeProvider.notifier).state =
                                          route;
                                      context.go(route);
                                    },
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    iconSize: 24,
                                  ),
                                  Text(
                                    ref
                                            .watch(AppProvider
                                                .instance.userProvider.notifier)
                                            .auth
                                            .currentUser
                                            ?.displayName ??
                                        '-',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.011,
                            ),
                            SizedBox(
                              width: context.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    width: context.width,
                                    child: const SearchBar(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) {
                      final masterPolicy = currentMasterPolicies[index];
                      return LoadingShaderShimmer(
                        isLoading: loading,
                        child: GestureDetector(
                          onTap: () {
                            final route =
                                '${AppRoutes.policy.policyRoute}$index';
                            context.go(route);
                            ref.read(routeProvider.notifier).state = route;
                            ref
                                .read(MasterPoliciesProvider
                                    .instance.selectedMasterPolicy.notifier)
                                .state = masterPolicy;
                          },
                          child: Hero(
                            tag: 'master-policy $index',
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: context.height * 0.028),
                              child: MasterPolicyCard(
                                masterPolicy: masterPolicy,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    childCount: currentMasterPolicies.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late TextEditingController searchTextEditController;

  @override
  void initState() {
    super.initState();
    searchTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    searchTextEditController.dispose();
    super.dispose();
  }

  void _onChanged(value) {
    ref.read(
        MasterPoliciesProvider.instance.searchMasterPoliciesProvider(value));
  }

  void _onClearSearch() {
    ref.read(MasterPoliciesProvider.instance.searchMasterPoliciesProvider(''));
    searchTextEditController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchTextEditController,
      onChanged: _onChanged,
      decoration: decoration(context),
    );
  }
}

extension _SearchBarDecoration on _SearchBarState {
  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 24,
        left: 0,
      ),
      prefixIcon: const SizedBox(
        width: 24,
        height: 24,
        child: Icon(
          Icons.search,
        ),
      ),
      suffixIcon: Align(
        alignment: Alignment.centerRight,
        widthFactor: 1.0,
        child: IconButton(
          onPressed: _onClearSearch,
          icon: Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
            ),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
