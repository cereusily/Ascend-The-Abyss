class Chaser extends Enemy {
  
  final int TRACK = 0;
  final int CHARGE = 1;
  int chaserState;
  
  int abilityThreshold;
  int abilityCooldown;
  
  int chargeTime;
  int chargeThreshold;
  int chargeSpeed;
  boolean charging;
  
  Chaser(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    // Timers
    health = 100;
    abilityThreshold = 200;
    chargeThreshold = 300;
    chargeSpeed = 10;
    charging = false;

    chaserState = TRACK;
  }
  
  void update() {
    super.update();

    if (abilityCooldown >= abilityThreshold) {
      chaserState = 1;
    }
    // Chaser states
    switch(chaserState) {
      case TRACK:
        track();
        break;
      case CHARGE:
        charge();
        break;
    }
    abilityCooldown++;
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
  
  void charge() {
    // Function managing charging
    if (chargeTime == 0) {  // once charging is out, stop charging
      charging = false;
    }
    if (chargeTime >= chargeThreshold || charging) {  // Once ability turned on, charging on
      PVector target = new PVector(player.pos.x - pos.x, player.pos.y - pos.y);
      pos.add(target.mult(0.05));
      charging = true;
      chargeTime--;
    }
    else {
      vel = new PVector();  // Stops mid way
      chargeTime++;
    }
  }
}
