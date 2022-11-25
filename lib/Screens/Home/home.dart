import 'package:audioplayer/components/NewBooks/new_books.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:audioplayer/components/AppTab/my_tabs.dart';
import '../../colors//themes/light_theme.dart' as light_colors;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List newBooks = [];
  List trendingBooks = [];

  ScrollController? _scrollController;
  TabController? _tabController;

  getPopularBooksData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books/popular_books.json")
        .then(
      (value) {
        setState(
          () {
            popularBooks = jsonDecode(value);
          },
        );
      },
    );
  }

  getNewBooksData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books/new_books.json")
        .then((value) {
      setState(() {
        newBooks = jsonDecode(value);
      });
    });
  }

  getTrendingBooksData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books/trending_books.json")
        .then((value) {
      setState(() {
        trendingBooks = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    getPopularBooksData();
    getNewBooksData();
    getTrendingBooksData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: light_colors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 24,
                      semanticLabel: 'Dashboard icon',
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24,
                          semanticLabel: 'Search icon',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 24,
                          semanticLabel: 'Notifications icon',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: ((popularBooks.isEmpty)
                                  ? 0
                                  : popularBooks.length),
                              itemBuilder: (BuildContext context, i) {
                                return Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(popularBooks[i]["img"]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              })),
                    )
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: light_colors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 20),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              tabs: const [
                                AppTab(
                                  color: light_colors.menu1Color,
                                  text: "New",
                                ),
                                AppTab(
                                  color: light_colors.menu2Color,
                                  text: "Popular",
                                ),
                                AppTab(
                                  color: light_colors.menu3Color,
                                  text: "Trending",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeBooks(books: newBooks),
                      HomeBooks(books: popularBooks),
                      HomeBooks(books: trendingBooks),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
