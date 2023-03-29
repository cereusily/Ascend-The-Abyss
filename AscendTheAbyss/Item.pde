class Item extends GameObject {
  // Class that manages items
  
  int type;
  Gun gun;
  
  String name;
  String description;
  
  
  Item(PVector pos, int roomX, int roomY, String name, String description) {
    super(pos, new PVector(), new PVector(gm.itemSpriteSize, gm.itemSpriteSize), roomX, roomY);
    
    // Descriptions of items
    this.name = name;
    this.description = description;
    
    // Health so item doesn't despawn
    health = 1;
    isFriendly = true;
  }
  
  void update() {
    super.update();
    
    // Determines effect
    if (hitObject(player)) {
      switch (type) {
        case MONEY:
          break;
        case CONSUMABLE:
          pickUpHealth();
          break;
        case RELIC:
          break;
        case GUN:
          break;
        case KEY:   
          pickUpKey();
          break;
        case LEVEL_KEY:
          break;
      }
    }
    
    // Displays info if mouse is hovering
    if (dist(mouseX, mouseY, pos.x, pos.y) < size.x/2) {
      displayInfo();
    }
  }
  
  void displayInfo() {
    push();
    translate(pos.x, pos.y + size.x);
    textSize(12);
    textAlign(CENTER);
    fill(255);
    text(name, 0, 0);
    text(description, 0, 20);
    pop();
  }
  
  void pickUpHealth() {
    if (player.health < player.maxHealth) {
      player.health++;
    }
    removeSelf();
  }
  
  void pickUpKey() {
    // Function to manage adding key to player inventory
    player.hasKey = true;
    removeSelf();
  }
  
  void displayMe() {
    // Renders in the inventory
    push();
    translate(50, 100);  // code here for inventory size
    ellipseMode(CENTER);
    fill(#FFFF00);
    ellipse(0, 0, size.x, size.y);
    pop();
  }
  
  void drawMe() {
    // Renders in game world
    push();
    translate(pos.x, pos.y);
    
    // If a sprite exists, draw the sprite
    if (sprite != null) {
      imageMode(CENTER);
      image(sprite, 0, 0, size.x, size.y);
    }
    else {
      ellipseMode(CENTER);
      fill(#FFFF00);
      ellipse(0, 0, size.x, size.y);
    }   
    pop();
  } 
  
  
}
