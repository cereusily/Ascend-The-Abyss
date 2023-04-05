class GameManager {
  // Class that manages game conditions and settings

  // Settings: Utility managers
  RoomManager room;

  // Settings: Player movement
  boolean moveUp, moveDown, moveLeft, moveRight;

  // Settings: Level
  int currentLevel;

  // Settings: Map
  PImage map;
  boolean doorsLocked;
  color northRoom, eastRoom, southRoom, westRoom;
  boolean northDoorLocked, eastDoorLocked, southDoorLocked, westDoorLocked;

  // Settings: Room colours
  int startRoomX;
  int startRoomY;
  color WALL = #FFFFFF;
  color ROOM = #000000;
  color START_ROOM = #A020F0;
  color ENEMY_ROOM = #FF0000;
  color ELITE_ROOM = #0000FF;
  color KEY_ROOM = #FFFF00;
  color BOSS_ROOM = #FF00FF;

  // Settings: animated sprite
  Animation playerProfile;

  // Settings: sprite sizes
  int playerSize;
  int enemySize;

  // Settings: Items
  int itemSpriteSize;
  HashMap<String, Item> itemsList;
  boolean keySpawned;

  // Settings: Sprites
  PImage playerSprite;
  PImage heartSprite;
  PImage emptyHeartSprite;

  PImage puddingSprite;
  PImage bossKeySprite;

  PImage skeletonSprite;
  PImage summonerSprite;
  PImage chestSprite;

  // Settings: objects
  ArrayList<GameObject> objectGroup;  // for objects stored globally on map; room group for object stored locally in room

  GameManager() {
    // Managers
    room = new RoomManager();

    // Settings
    playerSize = 70;
    enemySize = 80;
    itemSpriteSize = 40;

    // All game objects
    objectGroup = new ArrayList<GameObject>();
    itemsList = new HashMap<String, Item>();

    // Load images for sprites
    playerProfile = new Animation("sprites/gothie-profile/pixel-gothie_", 14, 6, new PVector(130, 130));
    playerSprite = loadImage("sprites/gothie-1.png");

    heartSprite = loadImage("sprites/heart.png");
    emptyHeartSprite = loadImage("sprites/empty-heart.png");

    puddingSprite = loadImage("sprites/pudding.png");
    bossKeySprite = loadImage("sprites/bossKey.png");

    // Set mode
    mode = INTRO;
    currentLevel = 0;

    // resets game
    resetGame();
  }

  /*
  =======================
   <---- Game States ---->
   =======================
   */

  void intro() {
    // Plays intro => temp stand in
    background(0);
    textSize(100);
    textAlign(CENTER);
    fill(255);
    text("ASCEND THE ABYSS", width/2, height/2);
    textSize(45);
    text("CLICK ANYWHERE TO START", width/2, height/2 + 70);

    if (mousePressed && mode == INTRO) {
      resetGame();
      mode = GAME;
    }
  }

  void runGame() {
    // Runs main game loop

    // Event listener
    checkEvents();

    // Gameplay
    checkDoors();
    drawRoom();
    room.drawObjects();

    // UI
    drawHUD();

    playerProfile.display(0, 0);
  }

  void pause() {
    //
  }

  void gameOver() {
    // Plays gameover => temp stand in
    background(0);
    textSize(100);
    textAlign(CENTER);
    fill(255);
    text("GAMEOVER", width/2, height/2);
    textSize(45);
    text("CLICK ANYWHERE TO RESTART", width/2, height/2 + 70);

    if (mousePressed && mode == GAMEOVER) {
      mode = INTRO;
    }
  }

  /*
  ============================
   <---- Helper Functions ---->
   ============================
   */

  void fillLevel() {
    // Loads enemies from map
    for (int i = 0; i < map.height; i++) {
      for (int j = 0; j < map.width; j++) {
        color r = map.get(j, i);

        // Room configurations
        if (r == START_ROOM) {
          startRoomX = j;
          startRoomY = i;
        }

        if (r == ENEMY_ROOM) {
          spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnStalker(new PVector(width/2, height/2), new PVector(), j, i);
          spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnStalker(new PVector(width/2 - 100, height/2 + 150), new PVector(), j, i);
          spawnStalker(new PVector(width/2 - 150, height/2), new PVector(), j, i);
          spawnStalker(new PVector(width/2 - 100, height/2 - 150), new PVector(), j, i);
        }
        if (r == ELITE_ROOM) {
          spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
        }
        if (r == KEY_ROOM) {
          spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnStalker(new PVector(width/2, height/2), new PVector(), j, i);
          spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnChest(new PVector(width/2, height/2), new PVector(), j, i);
        }
        if (r == BOSS_ROOM) {
          spawnChaser(new PVector(width/2, height/2), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 + 150), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 180, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 170, height/2 - 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 160, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 150, height/2 - 100), new PVector(), j, i);
          spawnGoal(new PVector(width/2, height/2), new PVector(), j, i);
        }
      }
    }
  }


  void lockAllDoors() {
    northDoorLocked = true;
    eastDoorLocked = true;
    southDoorLocked = true;
    westDoorLocked = true;
  }

  void unlockAllDoors() {
    northDoorLocked = false;
    eastDoorLocked = false;
    southDoorLocked = false;
    westDoorLocked = false;
  }

  boolean allDoorsLocked() {
    return northDoorLocked && eastDoorLocked && southDoorLocked && westDoorLocked;
  }

  void checkDoors() {
    // Locks the doors if more than one enemy in room
    if (!room.isClear()) {
      lockAllDoors();
    }
    if (room.isClear()) {
      unlockAllDoors();
    }
  }

  void resetGame() {
    // Resets game
    objectGroup.clear();
    room.clearAll();

    // Map
    map = loadImage("map/map" + currentLevel + ".png");

    // Keys
    keySpawned = false;

    // Populates level from map
    fillLevel();

    // Gameobjects
    player = new Player(new PVector(width/2, height/2), new PVector(), new PVector(playerSize, playerSize), startRoomX, startRoomY);
    player.sprite = playerSprite;
    player.hasKey = false;

    objectGroup.add(player);

    // Fills room
    fillRoom();
  }

  /*
     ===========================
   <---- Enemy Functions ---->
   ===========================
   */

  void spawnEnemy(PVector pos, PVector vel, int roomX, int roomY) {
    // Spawns in enemy
    Enemy newEnemy = new Enemy(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    objectGroup.add(newEnemy);
  }

  void spawnStalker(PVector pos, PVector vel, int roomX, int roomY) {
    // Spawns stalker enemy
    Stalker newStalker = new Stalker(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    objectGroup.add(newStalker);
  }

  void spawnSummoner(PVector pos, PVector vel, int roomX, int roomY) {
    // Spawns summoner enemy
    Summoner newSummoner = new Summoner(pos, vel, new PVector(enemySize + 20, enemySize + 20), roomX, roomY);
    objectGroup.add(newSummoner);
  }

  void spawnChaser(PVector pos, PVector vel, int roomX, int roomY) {
    Chaser newChaser = new Chaser(pos, vel, new PVector(enemySize + 20, enemySize + 20), roomX, roomY);
    objectGroup.add(newChaser);
  }

  void spawnChest(PVector pos, PVector vel, int roomX, int roomY) {
    Chest newChest = new Chest(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    objectGroup.add(newChest);
  }

  void spawnGoal(PVector pos, PVector vel, int roomX, int roomY) {
    GoalBlock newGoal = new GoalBlock(pos, vel, new PVector(100, 100), roomX, roomY);
    objectGroup.add(newGoal);
  }


  /*
   ==========================
   <---- Item Functions ---->
   ==========================
   */

  Item spawnPudding(PVector pos, int roomX, int roomY) {
    // Adds pudding
    Item pudding = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Pudding", "Mmm..pudding. I wonder how long it's been here? (Heal 1)");
    pudding.type = CONSUMABLE;
    pudding.sprite = puddingSprite;
    return pudding;
  }

  Item spawnBossKey(PVector pos, int roomX, int roomY) {
    // Adds item
    Item bossKey = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Boss Key", "A boss key! It has a lot of strange engravings on it (opens boss door)");
    bossKey.type = KEY;
    bossKey.sprite = bossKeySprite;
    return bossKey;
  }

  void fillRoom() {
    // Clear room objects
    room.clearAll();

    // Draws and updates all game objects
    for (int i = 0; i < objectGroup.size(); i++) {
      GameObject obj = objectGroup.get(i);

      // Only updates and draws if same room as player
      if (obj.roomX == player.roomX && obj.roomY == player.roomY) {
        room.addToRoom(obj);
      }
    }
  }

  void drawRoom() {
    background(139, 69, 19);

    // Draw corners
    stroke(0);
    strokeWeight(4);
    line(0, 0, width, height);
    line(width, 0, 0, height);

    // Draw exits
    // Identify which directions have exits through coloured pixels of map file
    // => black pixels = has doors, white pixels = no door
    northRoom = map.get(player.roomX, player.roomY - 1);
    eastRoom = map.get(player.roomX + 1, player.roomY);
    southRoom = map.get(player.roomX, player.roomY + 1);
    westRoom = map.get(player.roomX - 1, player.roomY);

    // Draws doors where exits are located
    noStroke();

    // Checks if doors locked
    if (!allDoorsLocked()) {
      fill(0);
    } else {
      fill(100);
    }

    // Will refactor this later LMAO

    // Draws doors
    if (northRoom != WALL) {
      ellipse(width/2, height * 0.1, 100, 100);
    }
    if (eastRoom != WALL) {
      ellipse(width * 0.9, height/2, 100, 100);
    }
    if (southRoom != WALL) {
      ellipse(width/2, height * 0.9, 100, 100);
    }
    if (westRoom != WALL) {
      ellipse(width * 0.1, height/2, 100, 100);
    }

    // Checks for boss room
    if (northRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        northDoorLocked = false;
        fill(0);
      } else {
        northDoorLocked = true;
        fill(BOSS_ROOM);
      }
      ellipse(width/2, height * 0.1, 100, 100);
    }
    if (eastRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        eastDoorLocked = false;
        fill(0);
      } else {
        eastDoorLocked = true;
        fill(BOSS_ROOM);
      }
      ellipse(width * 0.9, height/2, 100, 100);
    }
    if (southRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        eastDoorLocked = false;
        fill(0);
      } else {
        southDoorLocked = true;
        fill(BOSS_ROOM);
      }
      ellipse(width/2, height * 0.9, 100, 100);
    }
    if (westRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        westDoorLocked = false;
        fill(0);
      } else {
        westDoorLocked = true;
        fill(BOSS_ROOM);
      }
      ellipse(width * 0.1, height/2, 100, 100);
    }

    // Draw floor
    rectMode(CENTER);
    stroke(0);
    fill(160, 82, 45);
    rect(width/2, height/2, width * 0.8, height * 0.8);
  }

  /*
   ===================
   <---- UI/HUD ---->
   ===================
   */

  void drawHUD() {
    drawHealth();
    drawMiniMap();
    drawInventory();
  }

  void drawMiniMap() {
    // Draws a minimap onto the screen
    int miniMapRes = 15;

    push();
    rectMode(CENTER);
    noStroke();
    translate(width-200, 30);

    // Loops through map img and replaces pixel for player location
    for (int i = 0; i < map.height; i++) {
      for (int j = 0; j < map.width; j++) {
        if (player.roomX == j && player.roomY == i) {
          fill(255, 182, 193, 200);
        } else {
          color c = map.get(j, i);  // replaces pixel with original colour
          if (c == WALL) {
            fill(c, 10);  // Reduces wall opacity on map
          } else {
            fill(c, 200);  // Currently replaces with colour => can turn to image
          }
        }
        rect(j * miniMapRes, i * miniMapRes, miniMapRes, miniMapRes);  // draws mini map
      }
    }
    pop();
  }

  void drawHealth() {
    // Draws player health
    push();
    for (int i = 0; i < player.maxHealth; i++) {
      imageMode(CENTER);
      image(emptyHeartSprite, 180 + (i * 65), 60, 64, 64);
    }

    for (int i = 0; i < player.health; i++) {
      imageMode(CENTER);
      image(heartSprite, 180 + (i * 65), 60, 64, 64);
    }
    pop();
  }

  void drawInventory() {
    // draws player inventory
    push();

    translate(225, height - 60);
    fill(0, 0, 0, 140);
    rect(0, 0, 400, 50);

    push();
    for (int i = 0; i < player.inventory.size(); i++) {
      Item item = player.inventory.get(i);
      item.displayMe();
    }
    pop();

    pop();
  }


  void checkKeyPressed() {
    // Checks keys pressed
    if (key == CODED) {
      if (keyCode == UP) {
        moveUp = true;
        player.frontWalk.display(player.pos.x, player.pos.y);
      }
      if (keyCode == DOWN) {
        moveDown = true;
        player.frontWalk.display(player.pos.x, player.pos.y);
      }
      if (keyCode == LEFT) {
        moveLeft = true;
        player.frontWalk.display(player.pos.x, player.pos.y);
      }
      if (keyCode == RIGHT) {
        moveRight = true;
        player.frontWalk.display(player.pos.x, player.pos.y);
      }
      if (keyCode == SHIFT && player.switchCooldown == player.switchThreshold) {
        player.switchOmen();
      }
    } else {  // checks also for WASD
      if (key == 'w' || key == 'W') moveUp = true;
      if (key == 's' || key == 'S') moveDown = true;
      if (key == 'a' || key == 'A') moveLeft = true;
      if (key == 'd' || key == 'D') moveRight = true;
      if (key == 'e' || key == 'E' && player.switchCooldown == player.switchThreshold) {
        player.switchOmen();
      }
    }
  }

  void checkKeyReleased() {
    // Checks keys released
    if (key == CODED) {
      if (keyCode == UP) {
        moveUp = false;
      }
      if (keyCode == DOWN) {
        moveDown = false;
      }
      if (keyCode == LEFT) {
        moveLeft = false;
      }
      if (keyCode == RIGHT) {
        moveRight = false;
      }
    } else {  // Checks for WASD
      if (key == 'w' || key == 'W') moveUp = false;
      if (key == 's' || key == 'S') moveDown = false;
      if (key == 'a' || key == 'A') moveLeft = false;
      if (key == 'd' || key == 'D') moveRight = false;
    }
  }

  void checkEvents() {
    // Checks player movement
    if (moveUp) {
      player.accelerate(player.upAcc);
    }
    if (moveDown) {
      player.accelerate(player.downAcc);
    }
    if (moveRight) {
      player.accelerate(player.rightAcc);
    }
    if (moveLeft) {
      player.accelerate(player.leftAcc);
    }
    if (mousePressed && (mouseButton == LEFT)) {
      player.gun.shoot(player.getOmen());
    }
  }

}
