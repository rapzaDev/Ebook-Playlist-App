import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile(
      {super.key, required this.advancedPlayer, required this.audioPath});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    super.initState();
    onPlayerDurationChange();
    onPlayerPositionChange();
    widget.advancedPlayer.setSourceUrl(widget.audioPath);
    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  onPlayerDurationChange() {
    widget.advancedPlayer.onDurationChanged.listen(
      (value) {
        setState(() {
          _duration = value;
        });
      },
    );
  }

  onPlayerPositionChange() {
    widget.advancedPlayer.onPositionChanged.listen(
      (value) {
        setState(() {
          _position = value;
        });
      },
    );
  }

  Widget startButton() {
    return IconButton(
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Colors.blue,
            )
          : Icon(
              _icons[1],
              size: 50,
              color: Colors.blue,
            ),
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(UrlSource(widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget loadAsset() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        repeatButton(),
        slowButton(),
        startButton(),
        fastButton(),
        loopButton()
      ],
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  Widget repeatButton() {
    return IconButton(
      icon: Icon(
        Icons.repeat,
        size: 25,
        color: color,
      ),
      onPressed: () {
        if (isRepeat == false) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else if (isRepeat == true) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat = false;
            color = Colors.black;
          });
        }
      },
    );
  }

  Widget slowButton() {
    return IconButton(
      icon: const Icon(
        Icons.fast_rewind,
        size: 30,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget fastButton() {
    return IconButton(
      icon: const Icon(
        Icons.fast_forward,
        size: 30,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget loopButton() {
    return IconButton(
      icon: const Icon(
        Icons.loop,
        size: 25,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split(".")[0],
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                _duration.toString().split(".")[0],
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        slider(),
        loadAsset(),
      ],
    );
  }
}
