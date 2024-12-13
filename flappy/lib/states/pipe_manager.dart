import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy/components/pipes.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBird> {
  //update -> evert second (dt)

  //new pipe spawns

  double pipeSpawnTimer = 0.0;

  @override
  void update(double dt) {
    //generate new pipe at given time interval
    pipeSpawnTimer += dt;
    const double pipeInterval = 50;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0.0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = 150;
    const double pipeWidth = 60;
    const double minPipeHeight = 50;

    //calculate pipe heights

    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    //height of bottom pipe -> randomly select btw min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // create bottom pipe

    final bottomPipe = Pipe(
        Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
        Vector2(pipeWidth, bottomPipeHeight),
        isTopPipe: false);

    //create top pipe
    final topPipe = Pipe(
        Vector2(gameRef.size.x, 0), Vector2(pipeWidth, topPipeHeight),
        isTopPipe: true);

    //add pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
