import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy/components/background.dart';
import 'package:flappy/components/bird.dart';
import 'package:flappy/components/ground.dart';
import 'package:flappy/components/pipes.dart';
import 'package:flappy/components/score.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/states/pipe_manager.dart';
import 'package:flutter/material.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

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

    //load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    //load score
    scoreText = ScoreText();
    add(scoreText);
  }

//order matters (bg- bird etc)
  void onTap() {
    bird.flap();
    add(bird);
  }

  //score
  int score = 0;

  void incrementeScore() {
    score += 1;
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
              content: Text('HighScore: $score'),
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
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;

    children
        .whereType<Pipez>()
        .forEach((Pipez pipe) => pipe.removeFromParent());
    //remove all pipes from the games
    resumeEngine();
  }
}
