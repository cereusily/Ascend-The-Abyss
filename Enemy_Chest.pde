class Chest extends Enemy {
  // Class that manages a chest
  boolean hasKey;
  boolean isCommon;
  boolean isUncommon;
  boolean isRare;

  Chest(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    itemOdds = 100;
    health = 1;
    sprite = loadImage("sprites/enemies/chest.png");
    hasKey = false;
  }

  void update() {
    // Only updates/spawns when all enemies are dead
    if (gm.room.isClear()) {

      dropItem();

      if (hitObject(player)) {
        separate(player);
      }

      bulletCheck();
    }
  }
  
  
  void setRarity(String rarity) {
    // Sets the rarity of item
    isCommon = (rarity == "Common");
    isUncommon = (rarity == "Uncommon");
    isRare = (rarity == "Rare");
  }

  void dropItem() {
    // Drops items when dies
    if (health <= 0) {
      if ((int)random(0, 100) <= itemOdds) {  // gets odds
        spawnItem();
      }
      removeSelf();
    }
  }

  void spawnItem() {
    if (hasKey) {
      spawnKey();
    } else {
      spawnRandomItem();
    }
  }
  
  void spawnCommonItem() {
    // Spawns a random common item
    int randInt = (int) random(0, 2);
    switch (randInt) {
    case 0:
      spawnPudding();
      break;
    case 1:
      spawnBoots();
      break;
    default:
      spawnLantern();
      break;
    }
  }
  
  void spawnUncommonItem() {
    // Spawns a random uncommon item
    int randInt = (int) random(0, 5);
    switch (randInt) {
    case 0:
      spawnMaxHealth();
      break;
    case 1:
      spawnBar();
      break;
    case 2:
      spawnBoots();
      break;
    case 3:
      spawnDrink();
      break;
    case 4:
      spawnLantern();
      break;
    }
    
  }
  
  void spawnRareItem() {
    // Spawns a random rare item
    int randInt = (int) random(0, 3);
    switch (randInt) {
    case 0:
      spawnRicochet();
      break;
    case 1:
      spawnBar();
      break;
    case 2:
      spawnDrink();
      break;
    default:
      spawnMaxHealth();
      break;
    }
  }

  void spawnRandomItem() {
    // Spawns a random item
    if (isCommon) {
      spawnCommonItem();
    }
    if (isUncommon) {
      spawnUncommonItem();
    }
    if (isRare) {
      spawnRareItem();
    }
  }

  void spawnLantern() {
    // Drops lantern
    Item lantern = gm.spawnLantern(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(lantern);
    gm.room.addToRoom(lantern);
  }
  
  void spawnBar() {
    Item bar = gm.spawnProteinBar(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(bar);
    gm.room.addToRoom(bar);
  }
    
  
  void spawnDrink() {
    Item drink = gm.spawnEnergyDrink(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(drink);
    gm.room.addToRoom(drink);
  }

  void spawnMaxHealth() {
    // Drops max health
    Item maxHealth = gm.spawnMaxHealth(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(maxHealth);
    gm.room.addToRoom(maxHealth);
  }

  void spawnKey() {
    // Drops key
    Item bossKey = gm.spawnBossKey(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(bossKey);
    gm.room.addToRoom(bossKey);
  }
  
  void spawnRicochet() {
    // Spawns a ricochet bullet
    Item ricochet = gm.spawnRicochet(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(ricochet);
    gm.room.addToRoom(ricochet);
  }
  
  void spawnPudding() {
    // Spawns pudding
    Item pudding = gm.spawnPudding(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(pudding);
    gm.room.addToRoom(pudding);
  }
  
  
  void spawnBoots() {
    // drops boots
    Item boots = gm.spawnBoots(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(boots);
    gm.room.addToRoom(boots);
  }

  void drawMe() {
    // Draws key
    if (gm.room.isClear()) {
      push();
      translate(pos.x, pos.y);
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
      pop();
    }
  }
}
