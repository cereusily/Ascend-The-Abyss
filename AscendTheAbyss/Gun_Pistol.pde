class Pistol extends Gun {
  // Class that manages standard pistol gun
  // Init fields
  
  Pistol(PVector pos, PVector vel, ArrayList<Bullet> arr) {
    super(pos, vel, arr);
    
    // Size init; power is default =1 
    this.size = new PVector(15, 15);
    
    speed = 10;
    
    threshold = 65;
    cooldown = 25;
  }

  void shoot(String omen) {
    // Shoot gun
    if (cooldown >= threshold) {
      cooldown = 0;
      
      // Sets vector to mouse location
      PVector aimVector =  new PVector(mouseX - player.pos.x, mouseY - player.pos.y);
      aimVector.setMag(speed);
      
      if (canRicochet) {  // Ricochet bullet
        RicochetBullet newBullet = new RicochetBullet(new PVector(pos.x, pos.y), aimVector, size, arr);
        newBullet.isFriendly = isFriendly;
        newBullet.setOmen(omen);
        newBullet.bounceMax = ricochetAmount;
        arr.add(newBullet);
      }
      else {  // Regular bullet
        Bullet newBullet = new Bullet(new PVector(pos.x, pos.y), aimVector, size, arr);
        newBullet.isFriendly = isFriendly;
        newBullet.setOmen(omen);
        arr.add(newBullet);
      }
    }
  }

}
