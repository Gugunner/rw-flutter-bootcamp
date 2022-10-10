enum AppRoutes {
  home('/'),
  onboarding('/onboarding'),
  signin('/signin');

  // ignore: constant_identifier_names
  const AppRoutes(this.route);

  final String route;
}
