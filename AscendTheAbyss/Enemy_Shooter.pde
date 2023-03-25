class Shooter extends Enemy {
  // Fields
  
  Gun gun;
  Shooter(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    gun = new Pistol(pos, new PVector());
    gun.isFriendly = false;
  }
  
  void update() {
    //
  }
  
 
}
