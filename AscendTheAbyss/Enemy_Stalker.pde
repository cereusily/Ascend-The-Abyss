class Stalker extends Enemy {
  
  // Class that manages enemy that can track player
  float padding;

  Stalker(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    health = 3;
  }

  void update() {
    super.update();

    track();

    // Slows down if at half health
    if (health < maxHealth/2) {
      speed = 2.5;
    }
  }

  void drawMe() {
    // => Place holder
    push();
    translate(pos.x, pos.y);

    imageMode(CENTER);
    walk.display(0, 0);

    pop();
  }
}
