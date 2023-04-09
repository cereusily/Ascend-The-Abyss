class Summoner extends Enemy {
  // Class that manages a summoner enemy that can summon shit
  
  int summonMax;
  
  int summonCooldown;
  int summonThreshold;
  
  int dir;
  float angle;
  
  Summoner(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    // Sets health
    health = 10;
    
    // sprite
    sprite = loadImage("sprites/enemies/summoner.png");
    
    // Sets threshold for summoning
    summonMax = 6;
    
    // Odds for itemdrop
    itemOdds = 60;
    
    // Sets summon time
    summonCooldown = 0;
    summonThreshold = 150;
    
    // Directions for walk
    dir = 1;
    angle = -PI/4;
    speed = 3;
  }
  
  void update() {
    super.update();
    
    // Random walk
    if (hitObject(player)) {
      vel = new PVector();
    }
    else {
      walk();
    }
    // Summons stalker enemy
    summon();
    
    // Keeps track of summon time
    summonCooldown++;
  }
  
  void drawMe() {
    // Draws summoner
    push();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    image(sprite, 0, 0, size.x, size.y);
    //ellipseMode(CENTER);
    //fill(#FF00FF);
    //ellipse(0, 0, size.x, size.y);
    
    //fill(0);
    //textSize(30);
    //textAlign(CENTER);
    //text(health, 0, 10);
    
    
    pop();
  }
  
  void walk() {
    // Random walk
    angle += 0.04 * dir;
    
    if (random(0, 16) < 1) {
      dir *= -1;
    }
    vel.set(1.5 * cos(angle), 1.5 * sin(angle));
  }
  
  void summon() {
    if (gm.room.getAliveEnemiesCount() <= summonMax && summonCooldown >= summonThreshold) {    
      // Adds enemy to gameworld
      Stalker summon = new Stalker(new PVector(pos.x, pos.y + size.x), new PVector(), new PVector(gm.enemySize, gm.enemySize), roomX, roomY);
      gm.room.addToRoom(summon);
      summonCooldown = 0;
    }
  }
}
