import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy/components/background.dart';
import 'package:flappy/components/bird.dart';
import 'package:flappy/components/ground.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flutter/material.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;

  @override
  Future<void> onLoad() async {
    //load background
    background = Background(size);
    add(background);

    //load ground
    ground = Ground();
    add(ground);

    //load bird
    bird = Bird();
    add(bird);
  }

//order matters (bg- bird etc)
  void onTap() {
    bird.flap();
    add(bird);
  }

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    //show game over screen
    showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              actions: [
                TextButton(
                    onPressed: () {
                      //op box
                      Navigator.pop(context);

                      //restart game
                      restartGame();
                    },
                    child: const Text('Restart'))
              ],
            ));
  }

  void restartGame() {
    isGameOver = false;
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    resumeEngine();
  }
}
