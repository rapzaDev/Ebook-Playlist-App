import 'package:flutter/material.dart';

import 'package:audioplayer/Screens/DetailAudio/detail_audio.screen.dart';
import 'package:audioplayer/Screens/Home/home.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      home: DetailAudio(),
    );
  }
}
