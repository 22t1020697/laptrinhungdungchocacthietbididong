import 'package:dio/dio.dart';

class ApiService {
  static const String apiKey = "5b9dd85aec9b4e2788bc3d225e80350a";

  static const String endpoint =
      "https://newsapi.org/v2/everything"
      "?q=game OR gaming OR esports"
      "&language=en"
      "&sortBy=publishedAt"
      "&pageSize=20"
      "&apiKey=5b9dd85aec9b4e2788bc3d225e80350a";

  static Future<List<dynamic>> fetchNews() async {
    final dio = Dio();
    final response = await dio.get(endpoint);

    if (response.statusCode == 200 &&
        response.data["status"] == "ok") {
      return response.data["articles"];
    } else {
      return [];
    }
  }
}