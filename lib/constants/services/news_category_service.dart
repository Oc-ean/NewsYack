import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_yack_app/models/news_category_model.dart';

class NewsCategoryService {
  Future<List<NewsCategoryModel>> getCategoriesNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=6cdf19c3e3ab46ef91aad466634a9ee9";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          List<NewsCategoryModel> categories = [];
          jsonData["articles"].forEach((element) {
            if (element["urlToImage"] != null &&
                element['description'] != null) {
              NewsCategoryModel categoryModel = NewsCategoryModel(
                title: element["title"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                content: element["content"],
                author: element["author"],
              );
              categories.add(categoryModel);
            }
          });

          return categories;
        } else {
          throw Exception("Failed to load news");
        }
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      throw Exception("Failed to load news: $e");
    }
  }
}

// class NewsCategoryService {
//   List<NewCategoryModel> categories = [];
//
//   Future<void> getCategoriesNews(String category) async {
//     String url =
//         "https://newsapi.org/v2/top-headlines?country=us&category=&apiKey=6cdf19c3e3ab46ef91aad466634a9ee9";
//     var response = await http.get(Uri.parse(url));
//
//     var jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       jsonData["articles"].forEach((element) {
//         if (element["urlToImage"] != null && element['description'] != null) {
//           NewCategoryModel categoryModel = NewCategoryModel(
//             title: element["title"],
//             description: element["description"],
//             url: element["url"],
//             urlToImage: element["urlToImage"],
//             content: element["content"],
//             author: element["author"],
//           );
//           categories.add(categoryModel);
//         }
//       });
//     }
//   }
// }
