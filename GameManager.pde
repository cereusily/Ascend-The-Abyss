// Import minim
import ddf.minim.*;


class GameManager {
  // Class that manages game conditions and settings

  // Title screen
  Animation titleScreen;

  // Settings: Screen stuff
  float screenShake;
  float screenShakeTimer;
  float screenJitter;

  // Settings: Buttons  => Note: I made my own buttons because I didn't like ControlP5
  Button startButton;
  Button exitButton;
  Button resumeButton;
  Button quitButton;
  Button restartButton;

  // Settings: Utility managers
  RoomManager room;
  LevelManager lm;

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
  
  // Settings : Boss
  Boss boss;

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
  PImage tutorialSprite;

  PImage playerSprite;
  PImage heartSprite;
  PImage emptyHeartSprite;

  // Settings: Item sprites
  PImage puddingSprite;
  PImage bossKeySprite;
  PImage heartContainerSprite;
  PImage lanternSprite;
  PImage bootsSprite;
  PImage ricochetSprite;
  PImage energyDrinkSprite;
  PImage proteinBarSprite;

  PImage skeletonSprite;
  PImage summonerSprite;
  PImage chestSprite;

  // Door
  PImage doorSprite;
  PImage openDoorSprite;
  PImage closedDoorSprite;
  PImage openBossDoorSprite;
  PImage closedBossDoorSprite;

  Animation openingDoorSprite;

  // Settings: objects
  ArrayList<GameObject> objectGroup;  // for objects stored globally on map; room group for object stored locally in room
  ArrayList<DarkCell> darkCells;

  int darkCellSize;
  int darkCellX;
  int darkCellY;

  // Settings : Debug / Cheats
  boolean cheatsOn;

  // Settings: Audio
  AudioPlayer backgroundMusic;
  AudioPlayer titleScreenMusic;
  AudioPlayer hurtEffect;
  AudioPlayer pickUpEffect;
  AudioPlayer playerHurtEffect;
  AudioPlayer nextLevelEffect;
  AudioPlayer doorBellEffect;
  AudioPlayer gameOverEffect;

  boolean gameOverEffectPlayed = false;

  GameManager() {
    // Managers
    room = new RoomManager();
    sm = new SceneManager();
    lm = new LevelManager();

    // Audio
    backgroundMusic = minim.loadFile("audio/music/Lurking-Evil.mp3");
    titleScreenMusic = minim.loadFile("audio/music/Demented-Nightmare.mp3");
    hurtEffect = minim.loadFile("audio/effects/take-damage.mp3");
    pickUpEffect = minim.loadFile("audio/effects/pick-up.mp3");
    playerHurtEffect = minim.loadFile("audio/effects/player-take-damage.mp3");
    doorBellEffect = minim.loadFile("audio/effects/doorbell.mp3");
    gameOverEffect = minim.loadFile("audio/effects/game-over.mp3");

    nextLevelEffect = minim.loadFile("audio/effects/next-level.mp3");
    nextLevelEffect.setGain(-10);  // Lowers the volume for this effect because it's rlly loud LOL

    // Title Screen
    titleScreen = new Animation("title-screen/title-screen-", 4, 3, new PVector(width, height));

    // Buttons
    startButton = new Button(new PVector(width/2 - 100, height/2 + 100), new PVector(150, 50), "Start");
    exitButton = new Button(new PVector(width/2 + 100, height/2 + 100), new PVector(150, 50), "Exit");
    resumeButton = new Button(new PVector(width/2, height/2 + 25), new PVector(150, 50), "Resume");
    quitButton = new Button(new PVector(width/2, height/2 + 85), new PVector(150, 50), "Quit");
    restartButton = new Button(new PVector(width/2, height/2 + 25), new PVector(150, 50), "Restart");


    // Load font
    font = createFont("fonts/alagard.ttf", 128);
    textFont(font);

    // Settings
    playerSize = 40;
    enemySize = 80;
    itemSpriteSize = 40;

    // All game objects
    objectGroup = new ArrayList<GameObject>();
    itemsList = new HashMap<String, Item>();
    darkCells = new ArrayList<DarkCell>();

    darkCellSize = 5;
    darkCellX = 0;
    darkCellY = 0;

    // Load images for sprites
    tutorialSprite = loadImage("sprites/startRoom.png");
    playerProfile = new Animation("sprites/gothie-profile/pixel-gothie_", 14, 6, new PVector(170, 170));

    heartSprite = loadImage("sprites/heart.png");
    emptyHeartSprite = loadImage("sprites/empty-heart.png");
    heartContainerSprite = loadImage("sprites/items/heart-container.png");

    openDoorSprite = loadImage("sprites/door/door-000.png");
    closedDoorSprite = loadImage("sprites/door/door-006.png");
    openBossDoorSprite = loadImage("sprites/boss-door/boss-door-000.png");
    closedBossDoorSprite = loadImage("sprites/boss-door/boss-door-006.png");

    puddingSprite = loadImage("sprites/items/pudding.png");
    bossKeySprite = loadImage("sprites/items/bossKey.png");
    lanternSprite = loadImage("sprites/items/lantern.png");
    bootsSprite = loadImage("sprites/items/boots.png");
    ricochetSprite = loadImage("sprites/items/ricochet.png");
    energyDrinkSprite = loadImage("sprites/items/energy-drink.png");
    proteinBarSprite = loadImage("sprites/items/protein-bar.png");

    // Set mode
    gameMode = INTRO;
    currentLevel = 0;

    // Debug
    cheatsOn = false;
  }

  /*
  =======================
   <---- Game States ---->
   =======================
   */

  void runCheats() {
    // Function that sets player to cheats
    player.maxHealth = 1_000;
    player.health = 1_000;
    player.lightRadius = 300;
    player.gun.power = 10;
    player.gun.threshold = 10;
    player.gun.speed = 30;
    player.acc = 10;
    player.hasKey = true;
  }

  void intro() {
    // Plays intro => temp stand in
    background(0);
    titleScreen.display(width/2, height/2);  // display title screen at center

    playBackgroundMusic(titleScreenMusic);  // plays music

    startButton.display();  //display buttons
    exitButton.display();

    if (startButton.clickedOn() && gameMode == INTRO) {
      // Restarts game
      restartGame();
      gameMode = GAME;
      titleScreenMusic.rewind();
      titleScreenMusic.pause();
    }

    if (exitButton.clickedOn() && gameMode == INTRO) {
      // Quits game
      exit();
    }
  }

  void win() {
    // Plays winning game scene
    sm.playEscapeScene();

    // displays buttons to restart
    restartButton.display();
    quitButton.display();

    restartButton.onWhiteBackground = true;
    quitButton.onWhiteBackground = true;

    if (restartButton.clickedOn() && gameMode == WIN) {
      // Restarts game
      gameMode = GAME;

      restartButton.onWhiteBackground = false;
      quitButton.onWhiteBackground = false;
      restartGame();
    }
    if (quitButton.clickedOn() && gameMode == WIN) {
      // Quits back to titlescreen
      restartButton.onWhiteBackground = false;
      quitButton.onWhiteBackground = false;
      gameMode = INTRO;
    }
  }

  void runGame() {
    // Runs main game loop

    // Event listener
    checkEvents();

    // Checks
    checkDoors();

    // Rendering + Screen shake
    push();
    updateScreenShake();

    drawRoom();
    room.drawObjects();
    updateDarkness();

    // UI
    drawHUD();

    pop();

    // Plays intro scene
    if (!sm.introSceneOver) {
      sm.playIntroScene();
    }

    // Plays music
    playBackgroundMusic(backgroundMusic);
  }

  void pause() {
    // Draws pause
    push();
    rectMode(CENTER);
    fill(0, 0, 0, 25);
    rect(width/2, height/2, width, height);

    fill(255);
    textAlign(CENTER);
    textSize(64);
    text("=PAUSE=", width/2, height/2 - 50);

    // Text boxes
    resumeButton.display();
    quitButton.display();

    if (resumeButton.clickedOn()) {
      gameMode = GAME;
    }
    if (quitButton.clickedOn()) {
      gameMode = INTRO;
    }
    pop();
  }

  void gameOver() {
    // Plays gameover => temp stand in
    if (!gameOverEffectPlayed) {
      playSound(gameOverEffect);
      gameOverEffectPlayed = true;
    }
    background(0);
    textSize(100);
    textAlign(CENTER);
    fill(255);
    text("GAMEOVER", width/2, height/2 - 50);

    // Displays buttons
    restartButton.display();
    quitButton.display();

    if (restartButton.clickedOn() && gameMode == GAMEOVER) {
      restartGame();
      gameMode = GAME;
    }

    if (quitButton.clickedOn() && gameMode == GAMEOVER) {
      gameMode = INTRO;
    }
  }

  /*
  ==========================
   <---- Room functions ---->
   ==========================
   */
  void fillLevel() {
    // Loads enemies from map
    for (int i = 0; i < map.width; i++) {
      for (int j = 0; j < map.height; j++) {
        color r = map.get(i, j);

        // Room configurations
        if (r == START_ROOM) {
          startRoomX = i;
          startRoomY = j;
        }
        if (r == ENEMY_ROOM) {
          lm.getRegularRoom(currentLevel, i, j);
        } else if (r == ELITE_ROOM) {
          lm.getEliteRoom(currentLevel, i, j);
        } else if (r == KEY_ROOM) {
          lm.getEliteRoom(currentLevel, i, j);
          spawnKeyChest(new PVector(width/2 - 200, height/2), new PVector(), i, j);
        } else if (r == BOSS_ROOM) {
          lm.getBossRoom(currentLevel, i, j);
          spawnGoal(new PVector(width/2 - 200, height/2), new PVector(), i, j);
        } else {
        };
      }
    }
  }

  void lockAllDoors() {
    // loacks all doors
    northDoorLocked = true;
    eastDoorLocked = true;
    southDoorLocked = true;
    westDoorLocked = true;
  }

  void unlockAllDoors() {
    // unlocks all doors
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

  void createDarkness() {
    // Creates darkness cells
    while (darkCellY < height) {
      darkCells.add(new DarkCell(new PVector(darkCellX, darkCellY), darkCellSize));
      darkCellX += darkCellSize;
      if (darkCellX > width) {
        darkCellX = 0;
        darkCellY += darkCellSize;
      }
    }
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
    background(#990808);

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
      doorSprite = openDoorSprite;
    } else {
      doorSprite = closedDoorSprite;
    }

    // Will refactor this later LMAO

    // Draws doors
    push();
    imageMode(CENTER);
    if (northRoom != WALL) {
      image(doorSprite, width/2, height * 0.1, 100 + 50, 100 + 50);
    }
    if (eastRoom != WALL) {
      image(doorSprite, width * 0.9, height/2 + 20, 100 + 50, 100 + 100);
    }
    if (southRoom != WALL) {
      image(doorSprite, width/2, height * 0.9 + 25, 100 + 50, 200);
    }
    if (westRoom != WALL) {
      image(doorSprite, width * 0.1, height/2 + 20, 100, 100 + 100);
    }
    pop();

    // Checks for boss room
    if (northRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        northDoorLocked = false;
        doorSprite = openBossDoorSprite;
      } else {
        northDoorLocked = true;
        doorSprite = closedBossDoorSprite;
      }
      image(doorSprite, width/2, height * 0.1, 100 + 50, 100 + 50);
    }
    if (eastRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        eastDoorLocked = false;
        doorSprite = openBossDoorSprite;
      } else {
        eastDoorLocked = true;
        doorSprite = closedBossDoorSprite;
      }
      image(doorSprite, width * 0.9, height/2 + 20, 100 + 50, 100 + 100);
    }
    if (southRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        eastDoorLocked = false;
        doorSprite = openBossDoorSprite;
      } else {
        southDoorLocked = true;
        doorSprite = closedBossDoorSprite;
      }
      image(doorSprite, width/2, height * 0.9 + 25, 100 + 50, 200);
    }
    if (westRoom == BOSS_ROOM) {
      if (player.hasBossKey()) {
        westDoorLocked = false;
        doorSprite = openBossDoorSprite;
      } else {
        westDoorLocked = true;
        doorSprite = closedBossDoorSprite;
      }
      image(doorSprite, width * 0.1, height/2 + 20, 100, 100 + 100);
    }

    // Draw floor
    rectMode(CENTER);
    stroke(0);
    fill(#610f0f);
    rect(width/2, height/2, width * 0.8, height * 0.8);

    // Draws tutorial floor
    if (player.roomX == startRoomX && player.roomY == startRoomY && currentLevel == 0) {
      imageMode(CENTER);
      image(tutorialSprite, width/2, height/2);
    }
  }


  /*
  ============================
   <---- Helper Functions ---->
   ============================
   */

  void playBackgroundMusic(AudioPlayer m) {
    // Plays background music for game
    if (!m.isPlaying()) {
      m.rewind();
      m.play();
      m.setGain(-10);
    }
  }

  void playSound(AudioPlayer sound) {
    if (!sound.isPlaying()) {
      sound.rewind();
    }
    sound.play(0);
  }

  void clearGroup() {
    // Clears all objects in game except player
    for (int i = 0; i < objectGroup.size(); i++) {
      GameObject obj = objectGroup.get(i);

      if (!(obj instanceof Player)) {
        objectGroup.remove(obj);
      }
    }
  }

  void restartGame() {
    // Restarts game completely
    objectGroup.clear();
    room.clearAll();

    // Resets level
    currentLevel = 0;

    // Creates player
    player = new Player(new PVector(width/2, height/2), new PVector(), new PVector(playerSize, playerSize), startRoomX, startRoomY);
    player.sprite = playerSprite;

    //Adds player to group
    objectGroup.add(player);

    // Resets level
    resetGame();
  }

  void resetGame() {
    // Resets game level
    clearGroup();
    room.clearAll();

    // Map
    map = loadImage("map/map" + currentLevel + ".png");

    // Intro scene
    sm.introSceneOver = false;
    sm.effectPlayed = false;

    // Keys
    keySpawned = false;

    // Populates level from map
    fillLevel();

    // Gameobjects
    createDarkness();

    // Resets player settings
    player.hasKey = false;
    player.roomX = startRoomX;
    player.roomY = startRoomY;

    // Runs cheats
    if (cheatsOn) {
      runCheats();
    }

    // Fills room
    fillRoom();
  }

  void updateDarkness() {
    for (int i = 0; i < darkCells.size(); i++) {
      DarkCell d = darkCells.get(i);
      d.update();
      d.drawMe();
    }
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
    Summoner newSummoner = new Summoner(pos, vel, new PVector(enemySize - 20, enemySize - 20), roomX, roomY);
    objectGroup.add(newSummoner);
  }

  void spawnChaser(PVector pos, PVector vel, int roomX, int roomY) {
    Chaser newChaser = new Chaser(pos, vel, new PVector(enemySize + 20, enemySize + 20), roomX, roomY);
    objectGroup.add(newChaser);
  }

  void spawnBoss(PVector pos, PVector vel, int roomX, int roomY) {
    Boss newBoss = new Boss(pos, vel, new PVector(enemySize + 40, enemySize + 40), roomX, roomY);
    objectGroup.add(newBoss);
  }

  void spawnChest(PVector pos, PVector vel, int roomX, int roomY, String rarity) {
    Chest newChest = new Chest(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    newChest.setRarity(rarity);
    objectGroup.add(newChest);
  }

  void spawnKeyChest(PVector pos, PVector vel, int roomX, int roomY) {
    Chest newKeyChest = new Chest(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    newKeyChest.hasKey = true;
    objectGroup.add(newKeyChest);
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
    pudding.sprite = puddingSprite;
    return pudding;
  }

  Item spawnBossKey(PVector pos, int roomX, int roomY) {
    // Adds key
    Item bossKey = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Boss Key", "A boss key! It has a lot of strange engravings on it. (opens boss door)");
    bossKey.sprite = bossKeySprite;
    return bossKey;
  }

  Item spawnMaxHealth(PVector pos, int roomX, int roomY) {
    // Adds max health
    Item maxHealth = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Heart Container", "A heart container filled to the brim with a mysterious red fluid. (Max Health + 1)");
    maxHealth.sprite = heartContainerSprite;
    return maxHealth;
  }

  Item spawnLantern(PVector pos, int roomX, int roomY) {
    // adds lantern
    Item lantern = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Lantern", "An old lantern with a dim light. You can see a little more through the dark. (Increases light)");
    lantern.sprite = lanternSprite;
    return lantern;
  }

  Item spawnRicochet(PVector pos, int roomX, int roomY) {
    // adds ricochet
    Item ricochet = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Ricochet Bullet", "A strange bullet that bounces in your hand. (Bullet bounce + 1)");
    ricochet.sprite = ricochetSprite;
    return ricochet;
  }

  Item spawnBoots(PVector pos, int roomX, int roomY) {
    // adds boots
    Item boots = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Boots", "A comfortable pair of shoes that makes running a little eaasier. (Movement + 1)");
    boots.sprite = bootsSprite;
    return boots;
  }

  Item spawnEnergyDrink(PVector pos, int roomX, int roomY) {
    // Add energy drink
    Item drink = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Energy Drink", "A can filled with fizzing, caffeinated soda. Is this healthy to drink? (Attack speed + 1)");
    drink.sprite = energyDrinkSprite;
    return drink;
  }

  Item spawnProteinBar(PVector pos, int roomX, int roomY) {
    // Adds protein bar
    Item bar = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Protein Bar", "A protein bar that improves your strenght. (Attack power + 1)");
    bar.sprite = proteinBarSprite;
    return bar;
  }

  /*
   ===================
   <---- UI/HUD ---->
   ===================
   */

  void drawHUD() {
    playerProfile.display(playerProfile.getWidth(), playerProfile.getWidth());
    drawHealth();
    drawMiniMap();
    drawBossHealth();
  }
  
  void drawBossHealth() {
    if (boss != null && boss.health > 0 && boss.roomX == player.roomX && boss.roomY == player.roomY) {
      boss.displayHealthBar();
    }
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
          fill(START_ROOM);
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

  void checkKeyPressed() {
    if ((key == 'p' || key == 'P') && gameMode == GAME) {
      gameMode = PAUSE;
    }

    // Key stroke listeners
    if (key == CODED) {
      if (keyCode == UP) {
        moveUp = true;
      }
      if (keyCode == DOWN) {
        moveDown = true;
      }
      if (keyCode == LEFT) {
        moveLeft = true;
      }
      if (keyCode == RIGHT) {
        moveRight = true;
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

  void updateScreenShake() {
    // Updates any screen haking
    if (screenShakeTimer > 0) {
      screenJitter = random(-screenShake, screenShake);
      translate(screenJitter, screenJitter);
      screenShakeTimer--;
    }
  }
}
