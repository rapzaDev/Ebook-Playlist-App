import 'package:audioplayer/Screens/DetailAudio/detail_audio.screen.dart';
import 'package:flutter/material.dart';
import '../../colors/themes/light_theme.dart' as light_colors;

class HomeBooks extends StatelessWidget {
  final List books;
  const HomeBooks({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ((books.isEmpty) ? 0 : books.length),
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAudio(booksData: books, index: i),
              ),
            );
          },
          child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: light_colors.starColor),
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
                            borderRadius: BorderRadius.circular(3),
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
          ),
        );
      },
    );
  }
}
