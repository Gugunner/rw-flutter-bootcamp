import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavigationBottomBar extends ConsumerStatefulWidget {
  const ScaffoldNavigationBottomBar({
    super.key,
    required this.child,
    this.hasAppBar = false,
  });
  final Widget child;
  final bool hasAppBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScaffoldNavigationBottomBarState();
}

class _ScaffoldNavigationBottomBarState
    extends ConsumerState<ScaffoldNavigationBottomBar> {
  @override
  Widget build(BuildContext context) {
    final route = ref.watch(routeProvider.state).state;
    final currentIndex =
        AppRoutes.home.appRoutes.indexWhere((aR) => aR.route == route);
    return Scaffold(
      appBar: widget.hasAppBar ? AppBar() : null,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex > -1 ? currentIndex : 0,
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
        onTap: (index) {
          final route = AppRoutes.home.appRoutes
              .firstWhere((aR) => aR.currentTabIndex == index)
              .route;
          if (ref.read(routeProvider.notifier).state != route &&
              route == AppRoutes.home.route) {
            ref.read(MasterPoliciesProvider.instance.isLoading.notifier).state =
                true;
          }
          context.go(route);
          ref.read(routeProvider.notifier).state = route;
        },
      ),
    );
  }
}
