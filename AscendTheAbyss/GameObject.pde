class GameObject {
  // Class that maintains game objects
  
  // Default settings
  PVector pos, vel, size;
  PVector distance;
  PImage sprite;
  int health, maxHealth, deathTimer;
  float scaleFactor, rotateFactor;
  
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
    ellipseMode(CENTER);
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
  boolean isAlive() {
    // Checks if object is alive
    return deathTimer == -1;
  }
  
  void resolveCollide() {
    // Calculates distance so no overlap
    //distance = pos.sub(other.pos);
    
    ////  Calculates penetration depth of ellipse
    //float penDepth = size.x/2 + other.size.x/2 - distance.mag();
    //PVector penResolution = distance.normalize().mult(penDepth/2);
    
    //pos = pos.add(penResolution);
    //other.pos = other.pos.add(penResolution.mult(-1));
    PVector knockback = vel.copy().normalize().mult(-10);
    pos.add(knockback);
  }
  
  boolean hitObject(GameObject other) {
    // Checks if character got hit
    boolean hit = false;
    
    if (dist(this.pos.x, this.pos.y, other.pos.x, other.pos.y) < this.size.x) {
      hit = true;
    }
    return hit;
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
    this.health -= dmg;
  }
  
  void removeSelf() {
    gm.objectGroup.remove(this);
    gm.room.group.remove(this);
  }
}
