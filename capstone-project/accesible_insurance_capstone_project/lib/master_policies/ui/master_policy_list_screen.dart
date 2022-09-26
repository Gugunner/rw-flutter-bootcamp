import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/load_master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/master_policy_screen.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/loading_shader_shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/icons.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingMasterProvider = LoadMastersProvider.instance;
final appProvider = AppProvider.instance;

class MasterPolicyListScreen extends ConsumerWidget {
  const MasterPolicyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loadingMasterProvider.loadingProvider);
    final loading =
        ref.watch(loadingMasterProvider.isLoadingProvider.state).state;
    return Scaffold(
      body: SafeArea(
        child: IgnorePointer(
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
                        children: [
                          //Begins theme toggle implementation
                          Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              if (ref
                                      .watch(appProvider.themeProvider.state)
                                      .state ==
                                  ThemeMode.light)
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                            appProvider.themeProvider.notifier)
                                        .state = ThemeMode.dark;
                                  },
                                  icon: const Icon(
                                    AppIcons.ligthTheme,
                                    size: 32,
                                  ),
                                ),
                              if (ref
                                      .watch(appProvider.themeProvider.state)
                                      .state ==
                                  ThemeMode.dark)
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                            appProvider.themeProvider.notifier)
                                        .state = ThemeMode.light;
                                  },
                                  icon: const Icon(
                                    AppIcons.darkTheme,
                                    size: 32,
                                  ),
                                ),
                            ],
                          )
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
                          Navigator.push(context,
                              PageRouteBuilder(pageBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                          ) {
                            return const MasterPolicyScreen();
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: context.height * 0.028),
                          child: const MasterPolicyCard(),
                        ),
                      ),
                    );
                  }), childCount: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
