
///Blue print for all methods that are needed for implementing a paginated web service
///based on index position. Use this if the app pagination can be dynamically handled
///by the app.
abstract class PaginatedRepository {
  Future<List<dynamic>> getAllPaginated(int start, [int? end]);

  Future<int> getTotalPages();

  Future<dynamic> getEntity(String id);

}
