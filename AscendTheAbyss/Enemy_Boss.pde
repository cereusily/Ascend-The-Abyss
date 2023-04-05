class Boss extends Enemy {
  // Fields
  Gun bossGun;
  boolean isMeleePhase; // Flag for current phase
  int meleeDamage = 10; // Damage for melee attacks
  int rangedDamage = 20; // Damage for ranged attacks
  float rangedRange = 200; // Maximum range for ranged attacks
  float rangedSpeed = 5; // Speed of ranged attacks
  int bulletSize = 20;
  
  ArrayList<Bullet> bossBullets;
  
  Boss(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    bossBullets = new ArrayList<Bullet>();
    health = 100;
    
    
  }
  
   // Override parent update() method
  void update() {
    super.update(); // Call parent update() method

    // Switch between melee and ranged phases
    if (isMeleePhase && health < maxHealth/2) {
      isMeleePhase = false;
    } else if (!isMeleePhase && health <= 0) {
      isMeleePhase = true;
      health = maxHealth/2; // Restore health between phases
    }

    // Attack player based on current phase
    if (isMeleePhase) {
      // Melee attack: move towards player and deal damage on contact
      if (dist(pos.x, pos.y, player.pos.x, player.pos.y) <= size.x/2 + player.size.x/2) {
        player.decreaseHealth(meleeDamage);
      } 
      else {
        track();
      }
    } 
    else {
      // Ranged attack: shoot projectiles at player
      if (dist(pos.x, pos.y, player.pos.x, player.pos.y) <= rangedRange) {
        float angle = atan2(player.pos.y - pos.y, player.pos.x - pos.x);
        PVector bVel = new PVector(cos(angle), sin(angle)).mult(rangedSpeed);
        Bullet b = new Bullet(pos, bVel, new PVector(bulletSize, bulletSize), bossBullets);
        b.power = rangedDamage;
        bossBullets.add(b);
      }
    }
  }
  
   void track() {
    // Tracks player
    if (hitObject(player)) {
      vel = new PVector();
    }
    else {
      vel = new PVector(player.pos.x - pos.x, player.pos.y - pos.y);
      vel.setMag(speed);
    } 
  }
  
  void drawMe() {
    super.drawMe();
    text(health, pos.x, pos.y);
  }
  
}
