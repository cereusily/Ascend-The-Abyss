class Enemy extends GameObject {
  // Class that manages enemy
  float knockback;
  
  Enemy(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    maxHealth = 5;
    health = 5;
    omen = "BLACK";
    
    knockback = 10;
  
  }
  
  void update() {
    super.update();
    bulletCheck();
    
    // Makes player invincible if enemies hit
    if (hitObject(player) && !player.isInvincible) {
      player.gotHit(1);
    }
    
    // Drops items when dies
    if (health <= 0) {
      if (random(0, 10) < 1) {
        Item tempItem = new Item(new PVector(pos.x, pos.y), roomX, roomY, "Pudding", "Mmm..pudding. I wonder how long it's been here?");
        tempItem.type = 1;
        gm.room.addToRoom(tempItem);
      }   
      removeSelf();
    }
  }
  
  
  void bulletCheck() {
    // Checks if hit by bullet
    for (int i = 0; i < gm.room.group.size(); i++) {
      
      GameObject obj = gm.room.group.get(i);
      
      
      if (obj instanceof Bullet && hitObject(obj)) {
        PVector knockBack = obj.vel.normalize().mult(knockback);  // Gets opposite direction
        pos.add(knockBack);
        
        obj.removeSelf();
        
        // Checks if opposing omen
        if (obj.omen != this.omen) {
          decreaseHealth(player.gun.power * 2);
        }
        else {
          decreaseHealth(player.gun.power);
        }
      }
    }
  }
  
  void drawMe() {
    // => Place holder
    push();
    translate(pos.x, pos.y);
    fill(0, 255, 0);
    ellipseMode(CENTER);
    ellipse(0, 0, size.x, size.y);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(health, 0, 10);
    pop();
  }
}
