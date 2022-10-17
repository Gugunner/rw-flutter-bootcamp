import 'package:accesible_insurance_capstone_project/main.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../go_router.dart';

extension PumpAppToRoute on WidgetTester {
  ///Pumps a Widget that is mapped to a GoRoute
  Future<void> pumpAppToRoute(
    String location,
    //TODO: Implement dynamic child call
    //Simple builder that returns the child
    Widget Function(Widget child) builder, {
    //Any overrides needed with Riverpod Providers such as FirebaseAuth
    List<Override>? overrides,
    //Any observers needed with Riverpod such as a Logger
    List<ProviderObserver>? observers,
  }) {
    return pumpWidget(ProviderScope(
      observers: observers ?? [],
      overrides: overrides ?? [],
      child: MaterialApp.router(
        title: 'Tech Demo Widget Testing',
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        //router is a call to a GoRouter which has all the app routes
        routeInformationParser: router(location).routeInformationParser,
        routerDelegate: router(location).routerDelegate,
        routeInformationProvider: router(location).routeInformationProvider,
      ),
    ));
  }

  Future<void> pumpRealAppRouter({
    List<Override>? overrides,
    List<ProviderObserver>? observers,
  }) {
    return pumpWidget(
      ProviderScope(
        observers: observers ?? [],
        overrides: overrides ?? [],
        child: const MyApp(),
      ),
    );
  }
}
