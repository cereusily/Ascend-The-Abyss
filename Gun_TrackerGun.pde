class TrackerGun extends Gun {
  // Class that manages a tracking machinegun
  // Init fields
  float speed; 
  
  TrackerGun(PVector pos, PVector vel, ArrayList<Bullet> arr) {
    super(pos, vel, arr);
    
    // Size init; power is default =1 
    this.size = new PVector(30, 30);
    
    speed = 10;
    
    threshold = 10;
    cooldown = 0;
  }

  void shoot(String omen) {
    // Shoot gun
    if (cooldown == threshold) {
      cooldown = 0;
      
      float angle = atan2(player.pos.y - this.pos.y, player.pos.x - this.pos.x);
      
      PVector bulletV = new PVector(cos(angle) * speed, sin(angle) * speed);
      
      Bullet newBullet = new Bullet(new PVector(pos.x + bulletV.x * vel.x, pos.y + bulletV.y * vel.y), new PVector(bulletV.x * vel.x, bulletV.y * vel.y), size, arr);
      newBullet.setOmen(omen);
      newBullet.isFriendly = false;
      
      arr.add(newBullet);
    }
  }
}
