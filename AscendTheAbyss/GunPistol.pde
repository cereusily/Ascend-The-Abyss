class GunPistol extends Gun {
  // Init fields

  
  GunPistol(PVector pos, PVector vel) {
    super(pos, vel);
    
    // Size init; power is default =1 
    this.size = new PVector(30, 30);
    
    speed = 10;
    
    threshold = 25;
    cooldown = 25;
  }

  void shoot(String omen) {
    // Shoot gun
    if (cooldown >= threshold) {
      cooldown = 0;
      
      // Sets vector to mouse location
      PVector aimVector =  new PVector(mouseX - player.pos.x, mouseY - player.pos.y);
      aimVector.setMag(speed);
      
      // Adds bullet to gameobject array and sets omen
      Bullet newBullet = new Bullet(new PVector(pos.x, pos.y), aimVector, size);
      newBullet.setOmen(omen);
      gm.objectGroup.add(newBullet);
    }
  }
}
