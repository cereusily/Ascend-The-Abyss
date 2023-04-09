abstract class Gun {
  // Class that manages guns
  // Init fields
  
  float cooldown;
  float threshold;
  
  PVector pos, vel, size;
  ArrayList<Bullet> arr;
  
  boolean isFriendly;
  boolean canRicochet;
  int ricochetAmount;
  
  float speed; 
  int power;
  
  Gun(PVector pos, PVector vel, ArrayList<Bullet> arr) {
    this.pos = pos;
    this.vel = vel;
    this.arr = arr;
    
    // Default bullet size & power
    this.size = new PVector(15, 15);
    this.power = 1;
    this.ricochetAmount = 1;
  }

  void shoot(String omen) {
    // Shoots bullet is cooldown is off
    if (cooldown == threshold) {
      Bullet newBullet = new Bullet(this.pos, this.vel, this.size, arr);
      newBullet.power = this.power;
      newBullet.isFriendly = isFriendly;
      newBullet.setOmen(omen);
      arr.add(newBullet);
    }
  }
  
  void recharge() {
    if (cooldown < threshold) {
      cooldown++;
    }
  }
}
