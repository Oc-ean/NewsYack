import 'package:flutter/material.dart';
import 'package:news_yack_app/models/breaking_news_model.dart';
import 'package:news_yack_app/views/article_view.dart';

class BreakingNewsListsTile extends StatelessWidget {
  final List<BreakingNewsModel> newsCategory;
  const BreakingNewsListsTile({super.key, required this.newsCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2F41),
        title: const Text(
          'Breaking News',
        ),
      ),
      body: ListView.builder(
          itemCount: newsCategory.length,
          itemBuilder: (
            context,
            index,
          ) {
            return trendingListTile(newsCategory[index], context);
          }),
    );
  }

  Widget trendingListTile(dynamic article, BuildContext context) {
    final image = article.urlToImage;
    print('Article image: $image');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              model: article.url.toString(),
            ),
          ),
        );
      },
      child: Container(
        height: 350,
        width: 250,
        margin: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 165,
                margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5D0CC),
                  image: DecorationImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  article.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    // fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  article.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    // fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${article.publishedAt}  - ',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      '5 mins read  ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
