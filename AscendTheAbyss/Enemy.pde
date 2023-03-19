class Enemy extends GameObject {
  // Class that manages enemy
  
  Enemy(PVector pos, PVector vel, PVector size) {
    super(pos, vel, size);
    
    health = 5;
    omen = "BLACK";
  }
  
  void update() {
    super.update();
    bulletCheck();
  }
  
  void bulletCheck() {
    // Checks if hit by bullet
    for (int i = 0; i < gm.objectGroup.size(); i++) {
      GameObject obj = gm.objectGroup.get(i);
      if (obj instanceof Bullet && hitObject(obj)) {
        
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
    ellipse(0, 0, size.x, size.y);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(health, 0, 10);
    pop();
  }
}
