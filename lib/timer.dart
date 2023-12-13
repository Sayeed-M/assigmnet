import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_4/clock.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  bool isPlaying = false;
  bool isStarted = false;
  bool sound = false;

  final size = 300.0;

  AnimationController? controller;
  Animation? animation;
  final player = AudioPlayer();

  int step = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..addListener(() {
        // play sound in the last 5 seconds
        if (sound && animation!.value > 0.8) {
          player.play(AssetSource('countdown_tick.mp3')).onError(
                (error, stackTrace) => log(error.toString()),
              );
        }
        // if completed reset
        if (animation!.value == 1) {
          step++;
          controller!.reset();
          isPlaying = false;
        }
        setState(() {});
      });
    animation = Tween<double>(begin: 0.0, end: 1).animate(controller!);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mindful Meal Timer',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: step == 1 ? 15 : 12,
                width: step == 1 ? 15 : 12,
                decoration: BoxDecoration(
                  color: step == 1 ? Colors.white : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: step == 2 ? 15 : 12,
                width: step == 2 ? 15 : 12,
                decoration: BoxDecoration(
                  color: step == 2 ? Colors.white : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: step == 3 ? 15 : 12,
                width: step == 3 ? 15 : 12,
                decoration: BoxDecoration(
                  color: step == 3 ? Colors.white : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Text(
            (step == 0)
                ? 'Time to eat mindfully'
                : (step == 1)
                    ? 'Nom nom :)'
                    : (step == 2)
                        ? 'Break Time'
                        : 'Finish your meal',
            style: const TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            (step == 0)
                ? 'It\'s simple : eat slowly for ten minutes, rest for five, then finish your meal'
                : (step == 1)
                    ? 'You have 10 minutes to eat before the pause. Focus on eating slowly'
                    : (step == 2)
                        ? 'Take a five-minute break to check in on your level of fullness'
                        : 'You can eat until you feel full',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          MyCircularTimer(size: size, animation: animation),
          Wrap(
            direction: Axis.vertical,
            children: [
              CupertinoSwitch(
                value: sound,
                onChanged: (value) {
                  setState(() {
                    sound = value;
                  });
                },
              ),
              Text('Sound: ${sound ? 'On' : 'Off'}'),
            ],
          ),
          Wrap(
            spacing: 10.0,
            direction: Axis.vertical,
            children: [
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  // Add height and size
                  backgroundColor: const Color(0xFFAEC5B7),
                  minimumSize: const Size(300, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (step == 0) {
                    controller!.forward();
                    isStarted = true;
                    step++;
                  }
                  if (isPlaying) {
                    controller!.stop();
                  } else {
                    controller!.forward();
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                child: Text(
                  isPlaying
                      ? 'PAUSE'
                      : animation!.isCompleted || animation!.isDismissed
                          ? 'START'
                          : 'RESUME',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              isStarted
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // Add height and size
                        minimumSize: const Size(300, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Color(0xFFAEC5B7),
                          width: 1,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'LET\'S STOP I\'M FULL NOW ',
                        style: TextStyle(
                          color: Color(0xFFAEC5B7),
                          fontSize: 20,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
