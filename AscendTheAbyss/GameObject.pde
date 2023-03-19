class GameObject {
  // Class that maintains game objects
  
  // Default settings
  PVector pos, vel, size;
  PImage sprite;
  int health, deathTimer;
  float scaleFactor, rotateFactor;
  
  // Locations
  int roomX, roomY;
  
  // Game settings
  String omen;
  
  
  GameObject(PVector pos, PVector vel, PVector size) {
    this.pos = pos;
    this.vel = vel;
    this.size = size;
    
    // Sets timer
    deathTimer = -1;
  }
  
  void update() {
    move();
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
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
  boolean isAlive() {
    // Checks if object is alive
    return deathTimer == -1;
  }
  
  boolean hitObject(GameObject other) {
    // Checks if character got hit
    boolean hit = false;
    
    if (dist(this.pos.x, this.pos.y, other.pos.x, other.pos.y) < this.size.x/2) {
      hit = true;
    }
    return hit;
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
  }
  
  
}
