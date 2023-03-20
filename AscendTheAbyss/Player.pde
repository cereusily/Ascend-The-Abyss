class Player extends GameObject {
  // Class that manages the player
  
  // Movement
  float acc, damp;
  PVector upAcc, downAcc, leftAcc, rightAcc;
  
  // Omen states
  int switchCooldown;
  int switchThreshold;
  
  // States
  boolean isInvincible;
  color flash = color(255);  // temp fill
  
  // I-frame timer
  Timer iTimer;
  int iTime;
  
  // Player gun
  Gun gun;
  
  Player(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    // Dampenings
    acc = 8;
    damp = 0.77;
    
    // Accelerations
    upAcc = new PVector(0, -acc);
    downAcc = new PVector(0, acc);
    leftAcc = new PVector(-acc, 0);
    rightAcc = new PVector(acc, 0);
    
    // Timer
    iTimer = new Timer();
    
    // Gun
    gun = new Pistol(this.pos, new PVector());
    
    // Omen
    omen = "WHITE";
    switchThreshold = 20;
    
    // Settings
    maxHealth = 3;
    health = 3;
    isInvincible = false;
    iTime = 3_000;
  }
  
  void update() {
    // Dampens
    vel.mult(damp);
    
    // Adjusts vector
    if (vel.mag() > acc) {
      vel.setMag(acc);
    }
    
    // Calls update
    super.update();
    
    // Checks switching cooldown
    if (switchCooldown < switchThreshold) {
      switchCooldown++;
    }
    
    // Recharges gun
    gun.recharge();
    
    // Checks collisions
    checkCollisions();
    checkInvincible();
    
    // See if player is alive
    if (health <= 0) {
      mode = GAMEOVER;
    }
    
    // Checks exits
    if (!gm.doorsLocked) {
      checkExits();
    }    
  }
  
  void gotHit(int dmg) {
      player.iTimer.reset();
      player.isInvincible = true;
      player.decreaseHealth(dmg);
  }
  
  void checkInvincible() {
    // Makes player invincible if got hurt
    if (isInvincible && iTimer.getCurrentTime() >= iTime) {
      isInvincible = false;
      iTimer.pause();
    }
  }
  
  void checkExits() {
    // Checks if exit exists, adjacent pixel is black
    // North room => up
    if (gm.northRoom != gm.WALL && pos.y == height * 0.1 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY--;  // => moves up
      pos = new PVector(width/2, height * 0.9 - 10);
      gm.fillRoom();
    }
    // east room => right
    if (gm.eastRoom != gm.WALL && pos.x == width * 0.9 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX++;
      pos = new PVector(width * 0.1 + 10, height/2);
      gm.fillRoom();
    }
    // south room => down
    if (gm.southRoom != gm.WALL && pos.y == height * 0.9 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY++;
      pos = new PVector(width/2, height * 0.1 + 10);
      gm.fillRoom();
    }
    // west room => left
    if (gm.westRoom != gm.WALL && pos.x == width * 0.1 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX--;
      pos = new PVector(width * 0.9 - 10, height/2);
      gm.fillRoom();
    }
    // Moves gun with player
    gun.pos = this.pos;
  }
  
  void checkCollisions() {
    if (pos.x < width * 0.1) pos.x = width * 0.1;
    if (pos.x > width * 0.9) pos.x = width * 0.9;
    if (pos.y < height * 0.1) pos.y = height * 0.1;
    if (pos.y > height * 0.9) pos.y = height * 0.9;
  }
  
  void switchOmen() {
    // Swaps states
    this.switchCooldown = 0;
    this.setOmen((omen == "WHITE" ? "BLACK" : "WHITE"));
  }
  
  void drawMe() {
    // Draws in character => placeholder
    push();
    translate(pos.x, pos.y);
    fill(255,182,193);
    if (isInvincible) {
      fill(flash);
    }
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
}
