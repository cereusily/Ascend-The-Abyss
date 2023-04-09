class Player extends GameObject {
  // Class that manages the player

  // Movement
  float acc, damp;
  PVector upAcc, downAcc, leftAcc, rightAcc;

  // Omen states
  int switchCooldown;
  int switchThreshold;
  
  // Lighting
  float lightRadius;

  // States
  boolean isInvincible;

  // I-frame timer
  Timer iTimer;
  int iTime;

  // Player gun
  Gun gun;
  int knockback;
  ArrayList<Bullet> playerBullets;
  int ricochetAmount;
  
  // Animated sprites
  Animation idle;
  Animation moveDown;
  Animation moveUp;
  Animation moveRight;
  Animation moveLeft;

  // Has key
  boolean hasKey;

  Player(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);

    // Dampenings
    acc = 4;
    damp = 0.77;
    knockback = 10;

    // Accelerations
    upAcc = new PVector(0, -acc);
    downAcc = new PVector(0, acc);
    leftAcc = new PVector(-acc, 0);
    rightAcc = new PVector(acc, 0);

    // Timer
    iTimer = new Timer();
    
    // Animations
    idle = new Animation("sprites/gothie-idle/idle-", 8, 8, new PVector(size.x + 30, size.y + 30));
    moveDown = new Animation("sprites/gothie-move-down/move-down-", 4, 10, new PVector(size.x + 30, size.y + 30));
    moveUp = new Animation("sprites/gothie-move-up/move-up-", 4, 10, new PVector(size.x + 30, size.y + 30));
    moveRight = new Animation("sprites/gothie-move-right/move-right-", 4, 10, new PVector(size.x + 30, size.y + 30));
    moveLeft = new Animation("sprites/gothie-move-left/move-left-", 4, 10, new PVector(size.x + 30, size.y + 30));

    // Gun + Bullets
    playerBullets = new ArrayList<Bullet>();
    gun = new Pistol(this.pos, new PVector(), playerBullets);

    gun.isFriendly = true;
    gun.power = 1;
    gun.canRicochet = true;
    
    // Light radius
    lightRadius = 200;

    // Key
    hasKey = false;

    // Omen
    omen = "WHITE";
    switchThreshold = 20;

    // Modes
    isFriendly = true;

    // Settings
    maxHealth = 3;
    health = 3;
    isInvincible = false;
    iTime = 3_000;
  }

  void update() {
    // Dampens
    //println(gm.room.getAliveEnemiesCount());
    vel.mult(damp);

    // Adjusts vector
    if (vel.mag() > acc) {
      vel.setMag(acc);
    }

    // Calls update
    super.update();
    updateBullets();

    // Checks switching cooldown
    if (switchCooldown < switchThreshold) {
      switchCooldown++;
    }

    // Recharges gun
    gun.recharge();

    // Check invincibility
    checkInvincible();
    checkBullet();

    // See if player is alive
    if (health <= 0) {
      gameMode = GAMEOVER;
    }

    // Checks exits
    if (!gm.allDoorsLocked()) {
      checkExits();
    }
  }

  void gotHit(int dmg) {
    gm.screenShakeTimer = 20;
    gm.screenShake = 10;
    player.iTimer.reset();
    player.isInvincible = true;
    player.decreaseHealth(dmg);
  }
  
  void decreaseHealth(int dmg) {
    // decreases health
    gm.playSound(gm.playerHurtEffect);
    this.health -= dmg;
  }

  void checkInvincible() {
    // Makes player invincible if got hurt
    if (isInvincible && iTimer.getCurrentTime() >= iTime) {
      isInvincible = false;
      iTimer.pause();
    }
  }

  boolean hasBossKey() {
    //
    return hasKey;
  }

  void updateBullets() {
    // Updates bullets in array
    for (int i = 0; i < playerBullets.size(); i++) {
      Bullet b = playerBullets.get(i);      
      for (int j = i + 1; j < playerBullets.size(); j++) {
        // Check ricochets
        
        Bullet b2 = playerBullets.get(j);
        if (b.hitObject(b2) && b.omen != b2.omen) {
          b.resolveCollision(b2);
        }
      }
      b.update();
      b.drawMe();
    }
  }


  void checkBullet() {
    // Checks if hit by bullet
    for (int i = 0; i < gm.room.group.size(); i++) {

      GameObject obj = gm.room.group.get(i);

      // Checks if obj is a bullet
      if (obj instanceof Bullet && hitObject(obj) && !obj.isFriendly) {
        PVector knockBack = obj.vel.normalize().mult(knockback);  // Gets opposite direction
        pos.add(knockBack);

        obj.removeSelf();

        // Checks if opposing omen
        if (obj.omen != this.omen) {
          decreaseHealth(obj.power * 2);
        } else {
          decreaseHealth(obj.power);
        }
      }
    }
  }

  void checkExits() {
    // Checks if exit exists, adjacent pixel is black
    if (!gm.northDoorLocked) {
      checkNorthExit();
    }
    if (!gm.eastDoorLocked) {
      checkEastExit();
    }
    if (!gm.southDoorLocked) {
      checkSouthExit();
    }
    if (!gm.westDoorLocked) {
      checkWestExit();
    }

    // Moves gun with player
    gun.pos = this.pos;
  }

  void checkNorthExit() {
    // North room => up
    if (gm.northRoom != gm.WALL && pos.y == height * 0.1 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY--;  // => moves up
      pos = new PVector(width/2, height * 0.9 - 10);
      gm.fillRoom();
    }
  }

  void checkEastExit() {
    // east room => right
    if (gm.eastRoom != gm.WALL && pos.x == width * 0.9 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX++;
      pos = new PVector(width * 0.1 + 10, height/2);
      gm.fillRoom();
    }
  }

  void checkSouthExit() {
    // south room => down
    if (gm.southRoom != gm.WALL && pos.y == height * 0.9 && pos.x >= width/2 - size.x/2 && pos.x <= width/2 + size.x/2) {
      roomY++;
      pos = new PVector(width/2, height * 0.1 + 10);
      gm.fillRoom();
    }
  }

  void checkWestExit() {
    // west room => left
    if (gm.westRoom != gm.WALL && pos.x == width * 0.1 && pos.y >= height/2 - size.y/2 && pos.y <= height/2 + size.y/2) {
      roomX--;
      pos = new PVector(width * 0.9 - 10, height/2);
      gm.fillRoom();
    }
  }

  void switchOmen() {
    // Swaps states
    this.switchCooldown = 0;
    this.setOmen((omen == "WHITE" ? "BLACK" : "WHITE"));
  }

  void drawMe() {
    push();
    translate(pos.x, pos.y);
    
    if (isInvincible) {
      noFill();
      stroke(255);
      ellipse(0, 0, size.x + 30, size.y + 30);
    }
    
    if (gm.moveDown) {
      moveDown.display(0, 0);
    }
    else if (gm.moveUp) {
      moveUp.display(0, 0);
    }
    else if (gm.moveRight) {
      moveRight.display(0, 0);
    }
    else if (gm.moveLeft) {
      moveLeft.display(0, 0);
    }
    else {
      idle.display(0, 0);  // idle animation
    }
    pop();
  }
}
