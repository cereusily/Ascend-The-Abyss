class LevelManager {
  // class that manages level difficulty
  LevelManager() {
  }

  void getRegularRoom(int level, int roomX, int roomY) {
    // Function that calculates what enemies to spawn depending on level
    switch (level) {
    case 0:
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2, height/2), new PVector(), roomX, roomY, "Common");
      break;
    case 1:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2 - 50, height/2), new PVector(), roomX, roomY, "Common");
      gm.spawnChest(new PVector(width/2 + 50, height/2), new PVector(), roomX, roomY, "Uncommon");
      break;
    case 2:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 150, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 - 150), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2, height/2), new PVector(), roomX, roomY, "Common");
      gm.spawnChest(new PVector(width/2 - 100, height/2), new PVector(), roomX, roomY, "Uncommon");
      gm.spawnChest(new PVector(width/2 + 100, height/2), new PVector(), roomX, roomY, "Uncommon");
      break;
    }
  }

  void getEliteRoom(int level, int roomX, int roomY) {
    // Function that calculates what enemies to spawn depending on level
    switch (level) {
    case 0:
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2, height/2), new PVector(), roomX, roomY, "Uncommon");
      break;
    case 1:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2 - 50, height/2), new PVector(), roomX, roomY, "Rare");
      gm.spawnChest(new PVector(width/2 + 50, height/2), new PVector(), roomX, roomY, "Uncommon");
      break;
    case 2:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnChaser(new PVector(width/2 - 100, height/2), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2, height/2), new PVector(), roomX, roomY, "Uncommon");
      gm.spawnChest(new PVector(width/2 - 100, height/2), new PVector(), roomX, roomY, "Uncommon");
      gm.spawnChest(new PVector(width/2 + 100, height/2), new PVector(), roomX, roomY, "Rare");
      break;
    }
  }

  void getBossRoom(int level, int roomX, int roomY) {
    // Function that calculates what enemies to spawn depending on level
    switch (level) {
    case 0:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2, height/2), new PVector(), roomX, roomY, "Rare");
      break;
    case 1:
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), roomX, roomY);
      gm.spawnStalker(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      gm.spawnChaser(new PVector(width/2 - 100, height/2), new PVector(), roomX, roomY);
      gm.spawnChaser(new PVector(width/2, height/2 - 100), new PVector(), roomX, roomY);
      gm.spawnChest(new PVector(width/2 - 50, height/2), new PVector(), roomX, roomY, "Rare");
      gm.spawnChest(new PVector(width/2 + 50, height/2), new PVector(), roomX, roomY, "Rare");
      break;
    case 2:
      gm.spawnBoss(new PVector(width/2, height/2), new PVector(), roomX, roomY);
      break;
    }
  }
}
