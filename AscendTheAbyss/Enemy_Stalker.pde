class Stalker extends Enemy {
  // Fields
  float speed;
  
  Stalker(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    // Sets stalker speed
    speed = 4;
  }
  
  void update() {
    // Calls super update
    super.update();
    
    // Slows down if at half health
    if (health < maxHealth/2) {
      speed = 2.5;
    }
    
    // Tracks player
    if (hitObject(player)) {
      vel = new PVector();
    }
    else {
      vel = new PVector(player.pos.x - pos.x, player.pos.y - pos.y);
      vel.setMag(speed);
    }
    
  }
  
  void drawMe() {
    // => Place holder
    push();
    translate(pos.x, pos.y);
    fill(0, 0, 255);
    ellipseMode(CENTER);
    ellipse(0, 0, size.x, size.y);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(health, 0, 10);
    pop();
  }
}
