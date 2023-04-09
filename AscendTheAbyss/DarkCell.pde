class DarkCell {
  // Class that represent each square of darkness
  float opacity;
  PVector pos;
  float size;
  
  DarkCell(PVector pos, float size) {
    this.pos = pos;
    this.size = size;
    opacity = 255;
  }
  
  void update() {
    // Calculates distance for light
    float d = dist(pos.x + size/2, pos.y + size/2, player.pos.x, player.pos.y);
    opacity = map(d, 0, player.lightRadius, -100, 100);
    
    // Sets limits for opacity
    if (opacity < 0) {
      opacity = 0;
    }
    if (opacity > 255) {
      opacity = 255;
    }
    
    opacity = 255 - opacity;
    
    // Accounts for bullets
    for (int i = 0; i < player.playerBullets.size(); i++) {
      Bullet b = player.playerBullets.get(i);
      
      float d2 = dist(pos.x + size/2, pos.y + size/2, b.pos.x, b.pos.y);
      float bulletOpacity = map(d2, 0, 100, 100, 255);
      
      if (bulletOpacity < 0) {
        bulletOpacity = 0;
      }
      if (bulletOpacity > 255) {
        bulletOpacity = 255;
      }
      opacity += (255 - bulletOpacity);
    }
    
    opacity = 255 - opacity;
    
    // Sets limits for opacity
    if (opacity < 0) {
      opacity = 0;
    }
    if (opacity > 255) {
      opacity = 255;
    }
  }
  
  void drawMe() {
    // Draws cell
    rectMode(CORNER);
    fill(0, 0, 0, opacity);
    noStroke();
    rect(pos.x, pos.y, size, size); 
  }
  
  
}
