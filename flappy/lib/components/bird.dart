import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy/components/ground.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  //bird size and position
  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdHeight, birdWidth));

  //physical properties
  double velocity = 0.0;
  double gravity = 300;
  final double jumpStrength = -300;

  @override
  FutureOr<void> onLoad() async {
    //load bird image
    sprite = await Sprite.load('bluebird-midflap.png');

    add(RectangleHitbox());
  }

  //jump
  void flap() {
    velocity = jumpStrength;
  }

  //update every second
  @override
  void update(double dt) {
    //gravity
    velocity += gravity * dt;

    //update bird position based on velocity
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    //check if the bird hits the ground
    if (other is Ground) {
      (parent as FlappyBird).gameOver();
    }
  }
}
