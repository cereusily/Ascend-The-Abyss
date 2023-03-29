class Chest extends Enemy {
  // Class that manages a chest

  Chest(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    itemOdds = 100;
    sprite = loadImage("chest.png");
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
      bulletCheck();
    }
  }

  void spawnItem() {
    // Drops key
    Item bossKey = gm.spawnBossKey(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(bossKey);
    gm.room.addToRoom(bossKey);
  }

  void drawMe() {
    // Draws key
    if (gm.room.getAliveEnemiesCount() == 1) {
      push();
      translate(pos.x, pos.y);
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
      //ellipse(0, 0, size.x, size.y);
      pop();
    }
  }
}
