class GoalBlock extends GameObject {
  // Class that manages goal -> moves player to next level
  // Fields
  Boolean effectPlayed = false;

  GoalBlock(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    sprite = loadImage("sprites/goal.png");
  }

  void update() {
    // If no more enemies in room, reveal self
    if (gm.room.isClear() && gm.currentLevel == 2 && hitObject(player)) {
      gameMode = WIN;
    } else if (gm.room.isClear() && hitObject(player) && gm.currentLevel < 4) {
      gm.currentLevel++;
      gm.resetGame();
    }
  }

  void drawMe() {
    // Draws self
    if (gm.room.isClear()) {
      if (!effectPlayed) {  //plays sound if not played yet
        gm.playSound(gm.doorBellEffect);
        effectPlayed = true;
      }
      push();
      translate(pos.x, pos.y);
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
      pop();
    }
  }
}
