class GameObject {
  // Class that maintains game objects
  
  // Default settings
  PVector pos, vel, size;
  PVector distance;
  PImage sprite;
  int health, maxHealth, deathTimer, deathAnimationTime;
  float scaleFactor, rotateFactor;

  int power;
  boolean isFriendly;
  
  // Locations
  int roomX, roomY;
  
  // Game settings
  String omen;
  
  GameObject(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    this.pos = pos;
    this.vel = vel;
    this.size = size;
    this.roomX = roomX;
    this.roomY = roomY;
    
    // Distance vector
    distance = new PVector();
    
    // Sets timer
    deathTimer = -1;
  }
  
  void update() {
    move();
    checkCollisions();
  }
  
  void move() {
    pos.add(vel);
  }
  
  void accelerate(PVector acc) {
    vel.add(acc);
  }
  
  void drawMe() {
    // place holder
    push();
    translate(pos.x, pos.y);
      // If a sprite exists, draw the sprite
    if (sprite != null) {
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
    }
    else {
      ellipseMode(CENTER);
      fill(#FFFF00);
      ellipse(0, 0, size.x, size.y);
    }   
    pop();
  }
  
  boolean isAlive() {
    // Checks if object is alive
    return deathTimer == -1;
  }
  
  void resolveCollide() {
    // Calculates distance so no overlap
    PVector knockback = vel.copy().normalize().mult(-10);
    pos.add(knockback);
  }
  
  boolean hitObject(GameObject c) {
    return (abs(pos.x - c.pos.x) < size.x/2 + c.size.x/2 && abs(pos.y - c.pos.y) < size.y/2 + c.size.x/2);
  }
    
  void checkCollisions() {
    // Checks with walls
    if (pos.x < width * 0.1) pos.x = width * 0.1;
    if (pos.x > width * 0.9) pos.x = width * 0.9;
    if (pos.y < height * 0.1) pos.y = height * 0.1;
    if (pos.y > height * 0.9) pos.y = height * 0.9;
  }
  
  void setOmen(String newOmen) {
    this.omen = newOmen;
  }
  
  String getOmen() {
    return this.omen;
  }
  
  void decreaseHealth(int dmg) {
    gm.playSound(gm.hurtEffect);
    this.health -= dmg;
  }
  
  void removeSelf() {
    gm.objectGroup.remove(this);
    gm.room.group.remove(this);
  }
  
  void separate(GameObject obj) {
  }
}
