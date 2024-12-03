class Bullet extends GameObject {
  // Class that manages bullets
  color bulletInnerColour;
  color bulletOuterColour;
  ArrayList<Bullet> arr;
  int colourSize;

  Bullet(PVector pos, PVector vel, PVector size, ArrayList<Bullet> arr) {
    super(pos, vel, size, player.roomX, player.roomY); // Locations confined in player room
    this.arr = arr;
    health = 1;
    colourSize = 4;
  }

  void update() {
    super.update();
    updateBulletColour();
    checkCollisions();

    if (roomX != player.roomX || roomY != player.roomY) {
      removeSelf();
    }
  }

  void removeSelf() {
    arr.remove(this);
  }

  void drawMe() {
    // Colours
    push();
    translate(pos.x, pos.y);
    ellipseMode(CENTER);

    stroke(bulletOuterColour);
    strokeWeight(colourSize);

    fill(bulletInnerColour);
    ellipse(0, 0, size.x, size.y);
    pop();
  }

  void updateBulletColour() {
    // Updates bullet color to omen color
    switch(omen) {
    case "WHITE":
      bulletOuterColour = #FFD700;
      bulletInnerColour = color(255);
      break;
    case "BLACK":
      bulletOuterColour = #800B19;
      bulletInnerColour = color(20);
      break;
    }
  }

  void resolveCollision (GameObject other) {
    //find the angle they hit and bounce off each other
    float angle = atan2(pos.y - other.pos.y, pos.x - other.pos.x);
    
    //calculate the average speed
    float avgSpeed = (vel.mag() + other.vel.mag())/2;
    vel.set(avgSpeed * cos(angle), avgSpeed * sin(angle));
    other.vel.set(avgSpeed * cos(angle - PI), avgSpeed * sin(angle - PI));
  }

  void checkCollisions() {
    if (pos.x < width * 0.1) removeSelf();
    if (pos.x > width * 0.9) removeSelf();
    if (pos.y < height * 0.1) removeSelf();
    if (pos.y > height * 0.9) removeSelf();
  }
}
