class Boss extends Stalker {
  // Fields
  Gun bossGun;
  
  Boss(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    health = 100;
  }
  
  void update() {
    super.update();
    
    
  }
  
  void shoot() {
    //
  }
  
}
