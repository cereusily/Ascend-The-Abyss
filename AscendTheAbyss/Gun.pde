abstract class Gun {
  // Init fields
  
  float cooldown;
  float threshold;
  
  PVector pos, vel, size;
  
  float speed; 
  int power;
  
  Gun(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    
    // Default bullet size & power
    this.size = new PVector(15, 15);
    this.power = 1;
  }

  void shoot(String omen) {
    // Shoots bullet is cooldown is off
    if (cooldown == threshold) {
      Bullet newBullet = new Bullet(this.pos, this.vel, this.size);
      newBullet.power = this.power;
      newBullet.setOmen(omen);
      gm.room.addToRoom(newBullet);
    }
  }
  
  void recharge() {
    if (cooldown < threshold) {
      cooldown++;
    }
  }
}
