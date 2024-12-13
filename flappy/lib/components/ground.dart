import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy/constants/constants.dart';
import 'package:flappy/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBird>, CollisionCallbacks {
  //hasGmaeRef used to access the size of the phone
  //init
  Ground() : super();
  //load

  @override
  Future<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    //load img
    sprite = await Sprite.load('ground.png');

    //add collision
    add(RectangleHitbox());
  }

  //update every sec
  @override
  void update(double dt) {
    //move ground to left
    position.x -= groundscrollingSpeed * dt;

    //reset the ground if it goes out of screen for infinite scrolling
    //if the ground goes out of screen, reset it to the right of the screen
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
