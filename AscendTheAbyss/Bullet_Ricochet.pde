class RicochetBullet extends Bullet {
  // Class that manages special bullet that can ricochet
  int bounceCount;
  int bounceMax = 1;

  RicochetBullet(PVector pos, PVector vel, PVector size, ArrayList<Bullet> arr) {
    super(pos, vel, size, arr);
  }

  void update() {
    if (bounceCount >= bounceMax || roomX != player.roomX || roomY != player.roomY) {
      removeSelf();
    }
    updateBulletColour();
    move();
    checkCollisions();
  }

  void checkCollisions() {
    if (pos.x < width * 0.1 || pos.x > width * 0.9) {
      vel.x = -vel.x;
      bounceCount++;
    }
    if (pos.y < height * 0.1 || pos.y > height * 0.9) {
      vel.y = -vel.y;
      bounceCount++;
    }
  }
  
  void resolveCollision (GameObject other) {
    //find the angle they hit and bounce off each other
    float angle = atan2(pos.y - other.pos.y, pos.x - other.pos.x);
    
    //calculate the average speed
    float avgSpeed = (vel.mag() + other.vel.mag())/2;
    vel.set(avgSpeed * cos(angle), avgSpeed * sin(angle));
    other.vel.set(avgSpeed * cos(angle - PI), avgSpeed * sin(angle - PI));
    
    bounceCount++;
  }
}
