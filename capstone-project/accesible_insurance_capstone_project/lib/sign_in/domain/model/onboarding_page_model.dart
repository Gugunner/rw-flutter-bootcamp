class OnboardingPageModel {
  const OnboardingPageModel({
    required this.description,
    //TODO: Change url implementation in model once there are images ready
    this.imageUrl = '',
  });

  final String description;
  final String imageUrl;
}
