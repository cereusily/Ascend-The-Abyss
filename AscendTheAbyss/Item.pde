class Item extends GameObject {
  // Class that manages items
  // Honestly would've created a new class for each item but the tab manageme

  int type;

  Gun gun;

  String name;
  String description;
  int lanternStrength;


  Item(PVector pos, int roomX, int roomY, String name, String description) {
    super(pos, new PVector(), new PVector(gm.itemSpriteSize, gm.itemSpriteSize), roomX, roomY);

    // Descriptions of items
    this.name = name;
    this.description = description;

    // Health so item doesn't despawn
    health = 1;
    isFriendly = true;
    lanternStrength = 10;
  }

  void update() {
    super.update();

    // Determines effect
    if (hitObject(player)) {
      gm.playSound(gm.pickUpEffect);
      if (name == "Pudding") {
        pickUpHealth();
      }
      if (name == "Lantern") {
        pickUpLight();
      }
      if (name == "Boots") {
        pickUpSpeed();
      }
      if (name == "Heart Container") {
        pickUpMaxHealth();
      }
      if (name == "Ricochet Bullet") {
        pickUpRicochet();
      }
      if (name == "Energy Drink") {
        pickUpDrink();
      }
      if (name == "Protein Bar") {
        pickUpStrength();
      }
      if (name == "Boss Key") {
        pickUpKey();
      }
      removeSelf();
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
  }
  
  void pickUpStrength() {
    player.gun.power += 1;
  }

  void pickUpSpeed() {
    player.acc += 0.25;
  }

  void pickUpRicochet() {
    player.gun.ricochetAmount++;
  }

  void pickUpMaxHealth() {
    player.maxHealth++;
  }

  void pickUpLight() {
    player.lightRadius += 10;
  }

  void pickUpDrink() {
    if (player.gun.threshold > 10) {
      player.gun.threshold -= 5;
    }
  }

  void pickUpKey() {
    // Function to manage adding key to player inventory
    player.hasKey = true;
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
    } else {
      ellipseMode(CENTER);
      fill(#FFFF00);
      ellipse(0, 0, size.x, size.y);
    }
    pop();
  }
}
