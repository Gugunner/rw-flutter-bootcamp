enum AppRoutes {
  home('/', 0),
  onboarding('/onboarding', null),
  signin('/signin', null),
  signup('/signup', null),
  policy('policy/', null),
  store('/store', 1),
  profile('/profile', 2);

  // ignore: constant_identifier_names
  const AppRoutes(this.route, this.currentTabIndex);

  final String route;
  final int? currentTabIndex;

  String get policyRoute => '${home.route}${policy.route}';

  String get profileRoute => '${home.route}${profile.route}';

  List<AppRoutes> get appRoutes => [
        AppRoutes.home,
        AppRoutes.store,
        AppRoutes.profile,
      ];

  String upgradePolicyRoute(int index) =>
      '${home.route}${policy.route}$index/${store.route}$index';
}
