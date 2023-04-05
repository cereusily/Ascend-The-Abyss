class GoalBlock extends GameObject {
  // Fields
  GoalBlock(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    sprite = loadImage("sprites/goal.png");
  }

  void update() {
    // If no more enemies in room, reveal self
    if (gm.room.getAliveEnemiesCount() == 0 && hitObject(player)) {
      gm.currentLevel++;
      gm.resetGame();
    }
  }

  void drawMe() {
    // Draws self
    if (gm.room.getAliveEnemiesCount() == 0) {
      push();
      translate(pos.x, pos.y);
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
      pop();
    }
  }
}
