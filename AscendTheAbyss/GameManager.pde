class GameManager {
  // Class that manages game conditions and settings
  
  // Settings: Utility managers
  RoomManager room;
  
  // Settings: Player movement
  boolean moveUp, moveDown, moveLeft, moveRight;
  
  // Settings: Map
  PImage map;
  boolean doorsLocked;
  color northRoom, eastRoom, southRoom, westRoom;
  
  // Settings: Room colours
  int startRoomX;
  int startRoomY;
  color WALL = #FFFFFF;
  color ROOM = #000000;
  color ENEMY_ROOM = #FF0000;
  color ELITE_ROOM = #0000FF;
  
  // Settings: sprite sizes
  int playerSize;
  int enemySize;
  
  // Settings: Items
  int itemSpriteSize;
  HashMap<String, Item> itemsList;
  
  // Settings: objects
  ArrayList<GameObject> objectGroup;
  
  GameManager() {
    // Managers
    room = new RoomManager();
    
    // Settings
    startRoomX = 1;
    startRoomY = 4;
    
    playerSize = 70;
    enemySize = 50;
    itemSpriteSize = 30;
    
    // All game objects
    objectGroup = new ArrayList<GameObject>();
    itemsList = new HashMap<String, Item>();
    
    // Level map
    map = loadImage("map3.png");
    
    // Set mode
    mode = INTRO;
    
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
    drawRoom();
    room.drawObjects();
    checkDoors();
    
    // UI
    drawHUD();
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
        color room = map.get(j, i);
        
        // Room configurations
        if (room == ENEMY_ROOM) {
          spawnStalker(new PVector(width/2, height/2), new PVector(), j, i);
        }
        if (room == ELITE_ROOM) {
          //spawnStalker(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          //spawnStalker(new PVector(width/2, height/2), new PVector(), j, i);
          //spawnStalker(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 + 100), new PVector(), j, i);
          spawnSummoner(new PVector(width/2 - 100, height/2 - 100), new PVector(), j, i);
        }
      }
    }  
  }
  
  void checkDoors() {
    // Locks the doors if in elite room => going to add conditions for bosses
    if (room.getAliveEnemiesCount() >= 1) {
      doorsLocked = true;
    }
    if (room.getAliveEnemiesCount() == 0) {
      doorsLocked = false;
    }
  }
  
  void resetGame() {
    // Resets game
    objectGroup.clear();
    room.clearAll();
    
    // Gameobjects
    player = new Player(new PVector(width/2, height/2), new PVector(), new PVector(playerSize, playerSize), startRoomX, startRoomY);
    objectGroup.add(player);
    
    // Populates level from map
    fillLevel();
    
    // Fills room
    fillRoom();
  }
  
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
    Summoner newSummoner = new Summoner(pos, vel, new PVector(enemySize, enemySize), roomX, roomY);
    objectGroup.add(newSummoner);
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
    background(139,69,19);
    
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
    
    if (!doorsLocked) {
      fill(0);
    }
    else {
      fill(100);
    }
    
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
    
    // Draw floor
    rectMode(CENTER);
    stroke(0);
    fill(160,82,45);
    rect(width/2, height/2, width * 0.8, height * 0.8);
  }
  
  /* 
  ===================
  <---- UI/HUD ---->
  ===================
  */
  
  void drawHUD() {
    displayHealth();
    drawMiniMap();
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
        }
        else {
          color c = map.get(j, i);  // replaces pixel with original colour
          if (c == WALL) {
            fill(c, 10);  // Reduces wall opacity on map
          }
          else {
            fill(c, 200);  // Currently replaces with colour => can turn to image
          }
        }
        rect(j * miniMapRes, i * miniMapRes, miniMapRes, miniMapRes);  // draws mini map
      }
    }
    pop();
  }
  
  void displayHealth() {
    // Draws player health
    push();
    for (int i = 0; i < player.health; i++) {
      rectMode(CENTER);
      fill(255, 0, 0);
      rect(50 + (i * 60), 50, 50, 50);
    }
    pop();
  }
   
  
  void checkKeyPressed() {
    // Checks keys pressed
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
    }
    else {  // checks also for WASD
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
    }
    else {  // Checks for WASD
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
