import 'package:flutter/material.dart';

class MyCircularTimer extends StatelessWidget {
  const MyCircularTimer({
    super.key,
    required this.size,
    required this.animation,
  });

  final double size;
  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 30,
      height: size + 30,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size + 30,
              height: size + 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Container(
              width: size - 30,
              height: size - 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '00 : ${(30 - (30 * animation!.value)).toInt() < 10 ? '0' : ''}${(30 - (30 * animation!.value)).toInt()}',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'minutes remaining',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.flip(
            flipX: true,
            child: Transform.rotate(
              angle: 3.14 + (3.14 / 2),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: 3.14 * 2,
                    stops: [animation!.value, animation!.value],
                    center: Alignment.center,
                    colors: [Colors.grey.withAlpha(75), Colors.green],
                  ).createShader(rect);
                },
                child: Center(
                  child: Container(
                    width: size - 50,
                    height: size - 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/radial_scale.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
