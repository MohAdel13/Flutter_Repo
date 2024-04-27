class Endpoint{
  static const String baseUrl = "https://newsapi.org/";
  static const String topHeadlinesEndpoint = "v2/top-headlines";
  static const String everythingEndpoint = "v2/everything";
  static Map<String, dynamic> getQuery({required String category}){
    Map<String, dynamic> query = {
      'country': 'eg',
      'apiKey': '50e18fb6e94b4fe08f1f0bbfdbdfb3ba',
      'category': category
    };
    return query;
  }

  static Map<String, dynamic> getSearchQuery({required String value}){
    Map<String, dynamic> query = {
      'q': value,
      'apiKey': '50e18fb6e94b4fe08f1f0bbfdbdfb3ba',
    };
    return query;
  }
}