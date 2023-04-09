class Enemy extends GameObject {
  // Class that manages enemy
  float speed;
  float itemOdds;
  float maxForce;
  float knockback;
  boolean hasKey;
  PVector acc;
  float padding;
  
  Animation walk;

  Enemy(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);

    // Enemy settings
    maxHealth = 5;
    health = 5;
    isFriendly = false;
    omen = "BLACK";
    knockback = 10;
    
    walk = new Animation("sprites/enemies/skeleton/skeleton-", 2, 10, new PVector(size.x, size.y));

    // Flocking settings
    maxForce = 0.03;
    power = 1;
    speed = 3;
    acc = new PVector();

    sprite = loadImage("sprites/enemies/skeleton.png");

    itemOdds = 5; //  itemOdds/100 chance of itemdrop; i.e. 5% chance of drop
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

  void separate(GameObject e) {
    // Calculates distance between each enemy

    if (e instanceof Enemy && e != this) {
      float dist = dist(pos.x, pos.y, e.pos.x, e.pos.y);

      if (dist <= padding) {
        PVector copyThis = new PVector(pos.x, pos.y);
        PVector copyOther = new PVector(e.pos.x, e.pos.y);

        PVector dir = copyThis.sub(copyOther);

        dir.normalize();

        vel.add(dir);
      }
    }
  }

  void track() {
    // Tracks player
    // Gets direction to player
    if (dist(pos.x, pos.y, player.pos.x, player.pos.y) >= padding) {
      PVector copy = new PVector(player.pos.x, player.pos.y);
      PVector dir = copy.sub(pos);
      dir.normalize();

      dir.mult(speed);

      vel = dir;
    } else {
      vel = new PVector();
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
    Item drop = gm.spawnPudding(new PVector(pos.x, pos.y), roomX, roomY);
    gm.objectGroup.add(drop);
    gm.room.addToRoom(drop);
  }

  void bulletCheck() {
    // Checks if hit by bullet
    for (int i = 0; i < player.playerBullets.size(); i++) {

      Bullet b = player.playerBullets.get(i);


      if (hitObject(b) && b.isFriendly) {
        PVector knockBack = b.vel.normalize().mult(knockback);  // Gets opposite direction
        pos.add(knockBack);

        b.resolveCollision(this);

        // Checks if opposing omen
        if (b.omen != this.omen) {
          decreaseHealth(player.gun.power * 2);
        } else {
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
