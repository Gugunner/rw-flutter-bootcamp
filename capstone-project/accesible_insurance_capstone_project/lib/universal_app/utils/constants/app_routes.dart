enum AppRoutes {
  home('/'),
  onboarding('/onboarding'),
  signin('/signin'),
  policy('policy/'),
  upgrade('upgrade/');

  // ignore: constant_identifier_names
  const AppRoutes(this.route);

  final String route;

  String get policyRoute => '${home.route}${policy.route}';

  String upgradePolicyRoute(int index) =>
      '${home.route}${policy.route}$index/${upgrade.route}$index';
}
