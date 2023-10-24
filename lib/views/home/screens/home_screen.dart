import 'package:flutter/material.dart';
import 'package:news_yack_app/constants/services/breaking_news_service.dart';
import 'package:news_yack_app/constants/services/news_category_service.dart';
import 'package:news_yack_app/constants/services/news_service.dart';
import 'package:news_yack_app/models/article_model.dart';
import 'package:news_yack_app/models/breaking_news_model.dart';
import 'package:news_yack_app/models/news_category_model.dart';
import 'package:news_yack_app/views/article_view.dart';
import 'package:news_yack_app/views/current/screens/breaking_news_tile.dart';
import 'package:news_yack_app/views/trending/screens/trending_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel> article = [];
  List<BreakingNewsModel> news = [];
  bool isLoading = true;

  @override
  void initState() {
    getNews();
    getBreakingNews();
    super.initState();
  }

  getNews() async {
    News newsData = News();
    await newsData.getNews();
    article = newsData.news;
    setState(() {
      isLoading = false;
    });
  }

  getBreakingNews() async {
    BreakingNews breakingNews = BreakingNews();
    await breakingNews.getNews();
    news = breakingNews.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          colors: [
            Colors.grey.shade100,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          backgroundColor: const Color(0xFF2E2F41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'All News',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BreakingNewsListsTile(newsCategory: news),
                    ),
                  );
                },
                child: const Text(
                  'Breaking News',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrendingListTile(
                        articleModel: article,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Trending News',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E2F41),
          elevation: 0.0,
          title: const Text(
            'NewsYack',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 70,
                  width: double.infinity,
                  color: const Color(0xFF2E2F41),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Breaking News!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BreakingNewsListsTile(
                                    newsCategory: news,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      color: const Color(0xFF2E2F41),
                    ),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 270,
                            child: ListView.builder(
                                itemCount: news.length,
                                clipBehavior: Clip.none,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final newsData = news[index];
                                  return Transform.translate(
                                    offset: const Offset(0.0, 20 / 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ArticleView(
                                              model: newsData.url.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 220,
                                        width: 250,
                                        margin: const EdgeInsets.only(
                                            left: 22, right: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 165,
                                                margin: const EdgeInsets.only(
                                                    top: 7, left: 7, right: 7),
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFD5D0CC),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 40,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        newsData.urlToImage!,
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  newsData.title!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    // fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '19/09/23  - ',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      '5 mins read  ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trending News!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrendingListTile(
                                articleModel: article,
                              ),
                            ),
                          );
                          print('Article is passing $article');
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const TabBar(
                  indicatorWeight: 2,
                  indicatorPadding: EdgeInsets.only(right: 35, left: 35),
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Business',
                    ),
                    Tab(
                      text: 'Entertainment',
                    ),
                    Tab(
                      text: 'General',
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5.2,
                  child: TabBarView(
                    children: [
                      FutureBuilder(
                        future:
                            NewsCategoryService().getCategoriesNews("business"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<NewsCategoryModel>? businessNews =
                                snapshot.data;
                            print('CategoryNews : $businessNews');
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                NewsCategoryModel news = businessNews![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                            model: news.url.toString()),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 320,
                                    width: 250,
                                    margin: const EdgeInsets.only(
                                        left: 22,
                                        right: 22,
                                        top: 10,
                                        bottom: 10),
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
                                        children: [
                                          Container(
                                            height: 210,
                                            margin: const EdgeInsets.only(
                                                top: 7, left: 7, right: 7),
                                            width: 350,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD5D0CC),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 40,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    news.urlToImage!,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              news.title!,
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
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '19/09/23  - ',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
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
                              },
                            );
                          }
                        },
                      ),
                      FutureBuilder(
                        future: NewsCategoryService().getCategoriesNews(
                            "entertainment"), // You may need to modify your service method to accept a category
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Data is ready, display it here.
                            List<NewsCategoryModel>? businessNews =
                                snapshot.data;
                            print('CategoryNews : $businessNews');
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                NewsCategoryModel news = businessNews![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                          model: news.url.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 320,
                                    width: 250,
                                    margin: const EdgeInsets.only(
                                        left: 22,
                                        right: 22,
                                        top: 10,
                                        bottom: 10),
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
                                        children: [
                                          Container(
                                            height: 210,
                                            margin: const EdgeInsets.only(
                                                top: 7, left: 7, right: 7),
                                            width: 350,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD5D0CC),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 40,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    news.urlToImage!,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              news.title!,
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
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '19/09/23  - ',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
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
                              },
                            );
                          }
                        },
                      ),
                      FutureBuilder(
                        future:
                            NewsCategoryService().getCategoriesNews("general"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<NewsCategoryModel>? businessNews =
                                snapshot.data;
                            print('CategoryNews : $businessNews');
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                NewsCategoryModel news = businessNews![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                            model: news.url.toString()),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 320,
                                    width: 250,
                                    margin: const EdgeInsets.only(
                                        left: 22,
                                        right: 22,
                                        top: 10,
                                        bottom: 10),
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
                                        children: [
                                          Container(
                                            height: 210,
                                            margin: const EdgeInsets.only(
                                                top: 7, left: 7, right: 7),
                                            width: 350,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD5D0CC),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 40,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    news.urlToImage!,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              news.title!,
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
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '19/09/23  - ',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
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
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
