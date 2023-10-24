import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_yack_app/models/breaking_news_model.dart';

class BreakingNews {
  List<BreakingNewsModel> news = [];

  Future<void> getNews() async {
    try {
      String url =
          'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=6cdf19c3e3ab46ef91aad466634a9ee9';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] == "ok") {
          List<dynamic> articles = data["articles"];
          news = articles
              .where((element) =>
                  element["urlToImage"] != null &&
                  element["description"] != null)
              .map((element) {
            return BreakingNewsModel(
              title: element["title"],
              description: element["description"],
              author: element["author"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"],
            );
          }).toList();
        }
      }
    } catch (e) {
      print('Get news error : $e');
    }
  }
}
