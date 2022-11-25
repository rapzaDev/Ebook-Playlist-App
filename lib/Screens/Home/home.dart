// ignore_for_file: unnecessary_const, sort_child_properties_last

import 'dart:convert';

import 'package:audioplayer/components/AppTab/my_tabs.dart';
import 'package:flutter/material.dart';
import '../../colors//themes/light_theme.dart' as light_colors;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];

  ScrollController? _scrollController;
  TabController? _tabController;

  getPopularBooksData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
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

  getBooksData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((value) {
      setState(() {
        books = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    getPopularBooksData();
    getBooksData();
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
                      ListView.builder(
                        itemCount: ((books.isEmpty) ? 0 : books.length),
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: light_colors.tabBarViewColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(books[i]["img"]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 24,
                                              color: light_colors.starColor,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              (books[i]["rating"]).toString(),
                                              style: const TextStyle(
                                                  color:
                                                      light_colors.starColor),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          books[i]["title"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          books[i]["text"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Avenir",
                                            color: light_colors.subTitleText,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 15,
                                          width: 60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: light_colors.loveColor,
                                          ),
                                          child: Text(
                                            books[i]["category"],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Avenir",
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
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
