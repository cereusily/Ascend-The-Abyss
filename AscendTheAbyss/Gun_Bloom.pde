class Bloom extends Gun {
  // Class that manages bloom gun
  // Init fields
  
  Bloom(PVector pos, PVector vel, ArrayList<Bullet> arr) {
    super(pos, vel, arr);
    
    // Size init; power is default =1 
    this.size = new PVector(30, 30);
    
    // Thresholds & cooldowns
    threshold = 110;
    cooldown = 10;
  }
  
  void shoot(String omen) {
    // Shoots only if cooldown
    if (cooldown == threshold) {
      float angle = 0;
      cooldown = 0;
      
      // While less than a circle
      while (angle <= TWO_PI) {
        Bullet newBullet = new Bullet(new PVector(pos.x + sin(angle) * vel.x, pos.y + cos(angle) * vel.y), new PVector(sin(angle) * vel.x, cos(angle) * vel.y), size, arr);
        newBullet.setOmen(omen);
        newBullet.isFriendly = isFriendly;
        newBullet.power = this.power;
        angle += PI/18;  // => 1 degree
        gm.room.addToRoom(newBullet);
      }
    }
  }
}
