enum AppRoutes {
  home('/'),
  onboarding('/onboarding'),
  signin('/signin'),
  signup('/signup'),
  policy('policy/'),
  profile('profile'),
  upgrade('upgrade/');

  // ignore: constant_identifier_names
  const AppRoutes(this.route);

  final String route;

  String get policyRoute => '${home.route}${policy.route}';

  String get profileRoute => '${home.route}${profile.route}';

  String upgradePolicyRoute(int index) =>
      '${home.route}${policy.route}$index/${upgrade.route}$index';
}
