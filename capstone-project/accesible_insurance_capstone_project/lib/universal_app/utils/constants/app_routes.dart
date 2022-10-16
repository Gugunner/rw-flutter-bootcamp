enum AppRoutes {
  home('/'),
  onboarding('/onboarding'),
  signin('/signin'),
  policy('/policy'),
  upgrade('/upgrade:policyId');

  // ignore: constant_identifier_names
  const AppRoutes(this.route);

  final String route;
}
