class Player extends GameObject {
  // Class that manages the player
  
  // Movement
  float acc, damp;
  PVector upAcc, downAcc, leftAcc, rightAcc;
  
  // Omen states
  int switchCooldown;
  int switchThreshold;
  
  // Player gun
  Gun gun;
  
  Player(PVector pos, PVector vel, PVector size) {
    super(pos, vel, size);
    
    // Location on map
    roomX = 1;
    roomY = 1;
    
    // Dampenings
    acc = 8;
    damp = 0.77;
    
    // Accelerations
    upAcc = new PVector(0, -acc);
    downAcc = new PVector(0, acc);
    leftAcc = new PVector(-acc, 0);
    rightAcc = new PVector(acc, 0);
    
    // Gun
    gun = new GunPistol(this.pos, new PVector());
    
    // Omen
    omen = "WHITE";
    switchThreshold = 20;
    
    // Settings
    health = 3;
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
    
    // Checks exits
    checkExits();
  }
  
  void checkExits() {
    // Checks if exit exists, adjacent pixel is black
    // North room => up
    if (gm.northRoom != #FFFFFF && pos.y == height * 0.1 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY--;  // => moves up
      pos = new PVector(width/2, height * 0.9 - 10);
    }
    // east room => right
    if (gm.eastRoom != #FFFFFF && pos.x == width * 0.9 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX++;
      pos = new PVector(width * 0.1 + 10, height/2);
    }
    // south room => down
    if (gm.southRoom != #FFFFFF && pos.y == height * 0.9 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY++;
      pos = new PVector(width/2, height * 0.1 + 10);
    }
    // west room => left
    if (gm.westRoom != #FFFFFF && pos.x == width * 0.1 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX--;
      pos = new PVector(width * 0.9 - 10, height/2);
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
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
}
