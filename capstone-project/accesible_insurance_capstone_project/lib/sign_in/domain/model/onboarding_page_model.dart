class PageModel {
  const PageModel({
    required this.description,
    //TODO: Change url implementation in model once there are images ready
    this.title = '',
    this.imageUrl = '',
  });

  final String title;
  final String description;
  final String imageUrl;
}
