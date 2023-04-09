class Boss extends Stalker {
  // Class that manages boss that can chase enemies with special phases
  Gun bossGun;
  int rangedDamage = 1; // Damage for ranged attacks
  float rangedRange = 200; // Minimum range for ranged attacks
  float rangedSpeed = 1; // Speed of ranged attacks
  int bulletSize = 20;

  String name;

  ArrayList<Bullet> bossBullets;

  Boss(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    bossBullets = new ArrayList<Bullet>();

    bossGun = new TrackerGun(this.pos, new PVector(rangedSpeed, rangedSpeed), bossBullets);
    bossGun.isFriendly = false;

    name = "Abaddon, The Destroyer";
    walk = new Animation("sprites/enemies/boss-skeleton/skeleton-", 2, 4, size);
    maxHealth = 600;
    health = 600;
    
    // Sets boss
    gm.boss = this;
  }

  // Override parent update() method
  void update() {
    super.update(); // Call parent update() method

    rangedAttack();

    updateBullets();
  }

  void rangedAttack() {
    // If player is within range
    float d = PVector.dist(this.pos, player.pos);

    if (d > rangedRange) {
      this.vel = new PVector();
      bossGun.shoot(omen);
    }

    bossGun.recharge();
  }

  void updateBullets() {
    // Updates bullets in array
    for (int i = 0; i < bossBullets.size(); i++) {
      Bullet b = bossBullets.get(i);

      b.update();
      b.drawMe();

      if (b.hitObject(player)) {
        player.gotHit(rangedDamage);
        bossBullets.remove(b);
      }
    }
  }

  void displayHealthBar() {
    // Displays health bar
    strokeWeight(0);
    fill(255, 0, 0);
    rectMode(CORNER);//map(health, 0, maxHealth, 0, 100)
    rect(width/2 - 200, height - 50, map(health, 0, maxHealth, 0, 400), 30, 20);
    textSize(36);
    textAlign(CENTER);
    fill(255);
    text(name, width/2, height - 50);
    textAlign(LEFT);
  }

  void drawMe() {
    push();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    walk.display(0, 0);
    pop();
  }
}
