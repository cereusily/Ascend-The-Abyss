class GameManager {
  // Class that manages game conditions and settings
  
  // Player movement
  boolean moveUp, moveDown, moveLeft, moveRight;
  
  // Map
  PImage map;
  color northRoom, eastRoom, southRoom, westRoom;
  
  ArrayList<GameObject> objectGroup;
  
  GameManager() {
    // All game objects
    objectGroup = new ArrayList<GameObject>();
    
    // Level map
    map = loadImage("map.png");
  }
  
  void initAssets() {
    // Init assets
  }
  
  void spawnEnemy(PVector pos, PVector vel, int roomX, int roomY) {
    // Spawns in enemy
    Enemy newEnemy = new Enemy(pos, vel, new PVector(50, 50));
    newEnemy.roomX = roomX;
    newEnemy.roomY = roomY;
    
    objectGroup.add(newEnemy);
  }
  
  void drawObjects() {
    // Draws and updates all game objects
    for (int i = 0; i < objectGroup.size(); i++) {
      GameObject obj = objectGroup.get(i);
      
      // Only updates and draws if same room as player
      if (obj.roomX == player.roomX && obj.roomY == player.roomY) {
        obj.update();
        obj.drawMe();
      }
 
      if (obj.health <= 0) {
        objectGroup.remove(i);
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
    fill(0);
    if (northRoom != #FFFFFF) {
      ellipse(width/2, height * 0.1, 100, 100);
    }
    if (eastRoom != #FFFFFF) {
      ellipse(width * 0.9, height/2, 100, 100);
    }
    if (southRoom != #FFFFFF) {
      ellipse(width/2, height * 0.9, 100, 100);
    }
    if (westRoom != #FFFFFF) {
      ellipse(width * 0.1, height/2, 100, 100);
    }
    
    // Draw floor
    rectMode(CENTER);
    stroke(0);
    fill(160,82,45);
    rect(width/2, height/2, width * 0.8, height * 0.8);
  }
  
  void drawHUD() {
    displayHealth();
    drawMiniMap();
  }
  
  void drawMiniMap() {
    // Draws a minimap onto the screen
    int miniMapRes = 15;
    
    push();
    rectMode(CENTER);
    translate(width-200, 30);
    
    // Loops through map img and replaces pixel for player location
    for (int i = 0; i < map.height; i++) {
      for (int j = 0; j < map.width; j++) {
        if (player.roomX == j && player.roomY == i) {
          fill(255, 182, 193, 200);
        }
        else {
          color c = map.get(j, i);  // replaces pixel with original colour
          fill(c, 200);
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
