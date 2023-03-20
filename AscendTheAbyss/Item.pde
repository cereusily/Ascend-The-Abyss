class Item extends GameObject {
  // Class that manages items
  final int MONEY = 0;
  final int CONSUMABLE = 1;
  final int RELIC = 2;
  final int GUN = 3;
  
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
  }
  
  void update() {
    super.update();
    
    // Determines effect
    if (hitObject(player)) {
      switch (type) {
        case MONEY:
          break;
        case CONSUMABLE:
          player.health++;
          break;
        case RELIC:
          break;
        case GUN:
          break;
      }
      removeSelf();
    }
  }
  
  boolean hitObject(GameObject c) {
    return (abs(pos.x - c.pos.x) < size.x/2 + c.size.x/2 && abs(pos.y - c.pos.y) < size.y/2 + c.size.x/2);
  }
  
  void drawMe() {
    push();
    translate(pos.x, pos.y);
    fill(#FFFF00);
    ellipse(0, 0, size.x, size.y);
    pop();
  } 
}
