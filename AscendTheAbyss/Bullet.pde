class Bullet extends GameObject {
  // Fields
  int power;
  color bulletInnerColour;
  color bulletOuterColour;
  int colourSize;
  
  Bullet(PVector pos, PVector vel, PVector size) {
    super(pos, vel, size);
    
    // Locations confined in player room
    roomX = player.roomX;
    roomY = player.roomY;
    
    health = 1;
    colourSize = 4;
  }
  
  void update() {
    super.update();
    updateBulletColour();
    checkCollisions();
  }
  
  void drawMe() {
    // Colours
    push();
    translate(pos.x, pos.y);
    
    stroke(bulletOuterColour);
    strokeWeight(colourSize);
   
    fill(bulletInnerColour);
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
   void updateBulletColour() {
    // Updates bullet color to omen color
    switch(omen){
      case "WHITE":
        bulletOuterColour = #FFD700;
        bulletInnerColour = color(255);
        break;
      case "BLACK":
        bulletOuterColour = #800B19;
        bulletInnerColour = color(20);
        break;
    } 
  }
  
  boolean hitObject(GameObject c) {
    return (abs(pos.x - c.pos.x) < size.x/2 + c.size.x/2 && abs(pos.y - c.pos.y) < size.y/2 + c.size.x/2);
  }
  
  void checkCollisions() {
    if (pos.x < width * 0.1) removeSelf();
    if (pos.x > width * 0.9) removeSelf();
    if (pos.y < height * 0.1) removeSelf();
    if (pos.y > height * 0.9) removeSelf();
  }
  
}
