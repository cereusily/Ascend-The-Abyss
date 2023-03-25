class Chest extends Enemy {
  // Class that manages a chest

  Chest(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    itemOdds = 100;
  }

  void update() {
    if (gm.room.getAliveEnemiesCount() == 1) {
      // Drops items when dies
      if (health <= 0) {
        if ((int)random(0, 100) <= itemOdds) {  // gets odds
          spawnItem();
        }
        removeSelf();
      }
    }
    bulletCheck();
  }

  void spawnItem() {
    // Drops key
    gm.room.addToRoom(gm.spawnBossKey(new PVector(pos.x, pos.y), roomX, roomY));
  }

  void drawMe() {
    // Draws key
    if (gm.room.getAliveEnemiesCount() == 1) {
      push();
      translate(pos.x, pos.y);
      ellipse(0, 0, size.x, size.y);
      pop();
    }
  }
}
