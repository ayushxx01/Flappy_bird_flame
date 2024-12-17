import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy/components/pipes.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBird> {
  // Timer to track when to spawn the next pipe
  double pipeSpawnTimer = 0.0;

  @override
  void update(double dt) {
    // Increment the timer by the delta time (time since last update)
    pipeSpawnTimer += dt;

    // Check if the timer has exceeded the interval for spawning pipes
    if (pipeSpawnTimer > pipeInterval) {
      // Reset the timer
      pipeSpawnTimer = 0.0;
      // Spawn a new pair of pipes
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    // Calculate the maximum height for the pipes
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // Randomly determine the height of the bottom pipe within the allowed range
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // Calculate the height of the top pipe based on the bottom pipe height and the gap
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // Create the bottom pipe with the calculated height
    final bottomPipe = Pipez(
        Vector2(gameRef.size.x, 0), // Set y position to 0 for the bottom pipe
        Vector2(pipeWidth, bottomPipeHeight),
        isTopPipe: false);

    // Create the top pipe with the calculated height
    final topPipe = Pipez(
        Vector2(
            gameRef.size.x,
            screenHeight -
                groundHeight -
                topPipeHeight), // Set y position to the bottom for the top pipe
        Vector2(pipeWidth, topPipeHeight),
        isTopPipe: true);

    // Add the pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
