import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: GameWidget(game: BouncingBallGame())),
    ),
  );
}

class BouncingBallGame extends FlameGame with TapDetector {
  late SpriteComponent ball;
  double velocityY = 0;
  final double gravity = 500; // pixels per second squared

  @override
  Future<void> onLoad() async {
    await images.load('background.png');
    await images.load('ball.tiff');

    SpriteComponent background =
        SpriteComponent()
          ..sprite = await loadSprite('background.png')
          ..size = size
          ..position = Vector2.zero();
    add(background);

    ball =
        SpriteComponent()
          ..sprite = await loadSprite('ball.tiff')
          ..size = Vector2.all(80)
          ..position = Vector2(size.x / 2 - 40, size.y / 2 - 40);

    add(ball);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!ball.isMounted) return;

    velocityY += gravity * dt;
    ball.y += velocityY * dt;

    if (ball.y + ball.height >= size.y) {
      ball.y = size.y - ball.height;
      velocityY = 0;
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!ball.isMounted) return;
    velocityY = -300; // jump up
  }
}
