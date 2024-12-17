import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/game.dart';

class Pipez extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBird> {
  final bool isTopPipe;

  // Indicates if the pipe has been scored
  bool scored = false;

  // Constructor to initialize the pipe with position, size, and type (top or bottom)
  Pipez(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  // Load the sprite for the pipe
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'tube-up.png' : 'tube-down.png');

    // Add a collision hitbox to the pipe
    add(RectangleHitbox());
  }

  // Update the pipe's position and check for scoring and removal
  @override
  void update(double dt) {
    // Move the pipe to the left
    position.x -= groundscrollingSpeed * dt;

    // Check if the bird has passed the pipe and update the score
    if (position.x + size.x < gameRef.bird.position.x && !scored) {
      scored = true;

      if (isTopPipe) {
        gameRef.incrementeScore();
      }
    }

    // Remove the pipe if it goes out of the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}