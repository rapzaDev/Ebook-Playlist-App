import 'package:audioplayer/components/AudioFile/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../colors/themes/light_theme.dart' as light_theme;

class DetailAudio extends StatefulWidget {
  final List booksData;
  final int index;
  const DetailAudio({super.key, required this.booksData, required this.index});

  @override
  State<DetailAudio> createState() => _DetailAudioState();
}

class _DetailAudioState extends State<DetailAudio> {
  AudioPlayer? advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: light_theme.audioBluishBackground,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: light_theme.audioBlueBackground,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    advancedPlayer!.stop();
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.24,
              height: screenHeight * 0.36,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      widget.booksData[widget.index]["title"],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                      ),
                    ),
                    Text(
                      widget.booksData[widget.index]["text"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    AudioFile(
                        advancedPlayer: advancedPlayer!,
                        audioPath: widget.booksData[widget.index]["audio"]),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.12,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                  color: light_theme.audioGrayBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(
                        image:
                            AssetImage(widget.booksData[widget.index]["img"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
