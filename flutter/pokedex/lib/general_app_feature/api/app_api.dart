
///Blueprint for any HTTP Request implementation whether
///direct or through a HTTP Request wrapper.
abstract class AppApi {
  ///A simple get HTTP request
  Future<dynamic> get(String path);
  ///A solid get HTTP request with query parameters
  Future<dynamic> getWithParameters(
      String path, Map<String, dynamic> parameters);
}
