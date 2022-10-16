enum AppRoutes {
  home('/'),
  onboarding('/onboarding'),
  signin('/signin'),
  store('/store');

  // ignore: constant_identifier_names
  const AppRoutes(this.route);

  final String route;
}
