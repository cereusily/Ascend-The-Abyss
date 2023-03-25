class Enemy extends GameObject {
  // Class that manages enemy
  float knockback;
  float speed;
  float itemOdds;
  boolean hasKey;
  
  Enemy(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    maxHealth = 5;
    health = 5;
    isFriendly = false;
    omen = "BLACK";
    knockback = 10;
    power = 1;
    speed = 4;
    
    itemOdds = 10; //  itemOdds/100 chance of itemdrop; i.e. 10% chance of drop
  }
  
  void update() {
    super.update();
    bulletCheck();
    
    checkHitPlayer();
    
    // Drops items when dies
    if (health <= 0) {
      if ((int)random(0, 100) <= itemOdds) {  // gets oods
        spawnItem();
      }   
      removeSelf();
    }
  }
  
  void checkHitPlayer() {
    // Makes player invincible if enemies hit
    if (hitObject(player) && !player.isInvincible) {
      player.gotHit(power);
    }
  }
  
  void spawnItem() {
    // Spawns item into room
    gm.room.addToRoom(gm.spawnPudding(new PVector(pos.x, pos.y), roomX, roomY));
  }
  
  void bulletCheck() {
    // Checks if hit by bullet
    for (int i = 0; i < gm.room.group.size(); i++) {
      
      GameObject obj = gm.room.group.get(i);
      
      
      if (obj instanceof Bullet && hitObject(obj) && obj.isFriendly) {
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
